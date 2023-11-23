import 'dart:async';
import 'dart:convert';

import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/models/tasks.dart';
import 'package:benji_rider/repo/utils/constants.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:flutter/foundation.dart';
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
    debugPrint(id);
    final response = await http.put(
      Uri.parse('$baseURL/drivers/acceptDeliveryRequest/$id'),
      headers: authHeader(),
    );
    debugPrint(response.body);
    debugPrint("${response.statusCode}");
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
    debugPrint(id);
    final response = await http.put(
      Uri.parse('$baseURL/drivers/rejectDeliveryRequest/$id'),
      headers: authHeader(),
    );
    debugPrint(response.body);
    debugPrint("${response.statusCode}");
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
      channelTask.sink.add(jsonEncode({
        'rider_id': UserController.instance.user.value.id,
      }));
    });

    channelTask.stream.listen((message) {
      setTasks(jsonDecode(message)['message'] as List);
      debugPrint('tasks $message');
    });
  }

  getCoordinatesSocket() {
    final wsUrl = Uri.parse('$websocketBaseUrl/updateRiderCoordinates/');
    channel = WebSocketChannel.connect(wsUrl);
    taskToBeDone();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      taskToBeDone();
    });

    channel.stream.listen((message) {
      debugPrint('message $message');
    });
  }

  closeTaskSocket() {
    channel.sink.close(status.goingAway);
    channelTask.sink.close(status.goingAway);
  }

  taskToBeDone() async {
    String latitude = '';
    String longitude = '';
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    } catch (e) {
      latitude = '';
      longitude = '';
      debugPrint('in catch');
    }
    debugPrint("${{
      'rider_id': UserController.instance.user.value.id,
      'latitude': latitude,
      'longitude': longitude
    }}");
    channel.sink.add(jsonEncode({
      'rider_id': UserController.instance.user.value.id,
      'latitude': latitude,
      'longitude': longitude
    }));
  }

  bool isAccepted(TasksModel val) {
    return val.acceptanceStatus == 'ACCP';
  }
}
