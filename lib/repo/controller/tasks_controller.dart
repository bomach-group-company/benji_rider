import 'dart:async';
import 'dart:convert';

import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/models/tasks.dart';
import 'package:benji_rider/repo/utils/constants.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class TasksController extends GetxController {
  static TasksController get instance {
    return Get.find<TasksController>();
  }

  var tasks = <TasksModel>[].obs;

  late WebSocketChannel channel;
  late WebSocketChannel channelTask;

  setTasks(List taskList) {
    List<TasksModel> newTasks = [];
    for (var task in taskList) {
      TasksModel newTask = TasksModel.fromJson(task);
      newTasks.add(newTask);
    }
    tasks.value = newTasks;
    update();
  }

  Future acceptTask(id) async {
    final response = await http.put(
      Uri.parse('$baseURL/drivers/acceptDeliveryRequest/$id'),
      headers: authHeader(),
    );
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
    final response = await http.put(
      Uri.parse('$baseURL/drivers/rejectDeliveryRequest/$id'),
      headers: authHeader(),
    );
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

    Timer.periodic(const Duration(minutes: 1), (timer) {
      print({
        'rider_id': UserController.instance.user.value.id,
      });
      channelTask.sink.add(jsonEncode({
        'rider_id': UserController.instance.user.value.id,
      }));
    });

    channelTask.stream.listen((message) {
      // print(message);
      setTasks(jsonDecode(message)['message'] as List);
      // print('tasks $message');
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
    channel.sink.close(status.goingAway);
    channelTask.sink.close(status.goingAway);
  }

  bool isAccepted(TasksModel val) {
    return val.acceptanceStatus == 'ACCP';
  }
}
