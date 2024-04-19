import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/delivery_model.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'api_url.dart';
import 'user_controller.dart';

class TasksController extends GetxController {
  static TasksController get instance {
    return Get.find<TasksController>();
  }

  var tasks = <DeliveryModel>[].obs;
  var isLoading = false.obs;

  late WebSocketChannel channel;
  late WebSocketChannel channelTask;

  setTasks(List taskList) {
    List<DeliveryModel> newTasks = [];
    for (var task in taskList) {
      DeliveryModel newTask = DeliveryModel.fromJson(task);
      newTasks.add(newTask);
    }
    tasks.value = newTasks;
    update();
  }

  Future acceptTask(id) async {
    isLoading.value = true;
    update();
    final response = await http.put(
      Uri.parse(
          '${Api.baseUrl}/drivers/acceptDeliveryRequest/$id/${UserController.instance.user.value.id}'),
      headers: authHeader(),
    );
    log('acceptTask ${response.statusCode}: ${response.body}');

    isLoading.value = true;
    update();
    if (response.statusCode == 200) {
      channelTask.sink.add(jsonEncode({
        'rider_id': UserController.instance.user.value.id,
      }));
      return;
    } else {
      throw Exception('Failed to load vendor');
    }
  }

  Future rejectTask(id) async {
    isLoading.value = true;
    update();
    final response = await http.put(
      Uri.parse(
          '${Api.baseUrl}/drivers/rejectDeliveryRequest/$id/${UserController.instance.user.value.id}'),
      headers: authHeader(),
    );
    log('rejectTask ${response.statusCode}: ${response.body}');

    isLoading.value = true;
    update();

    if (response.statusCode == 200) {
      channelTask.sink.add(jsonEncode({
        'rider_id': UserController.instance.user.value.id,
      }));
      return;
    } else {
      throw Exception('Failed to load vendor');
    }
  }

  getTasksSocket() {
    final wsUrlTask = Uri.parse('$websocketBaseUrl/getridertask/');
    channelTask = WebSocketChannel.connect(wsUrlTask);
    channelTask.sink.add(jsonEncode({
      'rider_id': UserController.instance.user.value.id,
    }));
    // log({
    //   'rider_id': UserController.instance.user.value.id,
    // });

    Timer.periodic(const Duration(minutes: 1), (timer) {
      channelTask.sink.add(jsonEncode({
        'rider_id': UserController.instance.user.value.id,
      }));
      // log({
      //   'rider_id': UserController.instance.user.value.id,
      // });
    });

    channelTask.stream.listen((message) {
      log(message);
      List data = [];
      data.addAll(jsonDecode(message)['message'] as List);
      data.addAll(jsonDecode(message)['packages'] as List);

      setTasks(data);
      isLoading.value = false;
      update();
    });
  }

  getCoordinatesSocket() {
    final wsUrl = Uri.parse('$websocketBaseUrl/updateRiderCoordinates/');
    channel = WebSocketChannel.connect(wsUrl);
    getCoordinates();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      getCoordinates();
    });

    channel.stream.listen((message) {});
  }

  getCoordinates() async {
    String latitude = '';
    String longitude = '';
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      channel.sink.add(jsonEncode({
        'rider_id': UserController.instance.user.value.id,
        'latitude': latitude,
        'longitude': longitude
      }));
    } catch (e) {
      latitude = '';
      longitude = '';
    }
  }

  closeTaskSocket() {
    channel.sink.close(1000);
    channelTask.sink.close(1000);

    // channel.sink.close(status.goingAway);
    // channelTask.sink.close(status.goingAway);
  }

  bool isAccepted(DeliveryModel val) {
    return val.acceptanceStatus == 'ACCP';
  }
}
