// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:benji_rider/src/repo/models/task_item_status_update.dart';
import 'package:benji_rider/src/repo/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/delivery_model.dart';
import '../models/order_model.dart';
import 'api_url.dart';
import 'error_controller.dart';
import 'order_controller.dart';
import 'user_controller.dart';

class OrderStatusChangeController extends GetxController {
  static OrderStatusChangeController get instance {
    return Get.find<OrderStatusChangeController>();
  }

  var isLoadUpdateStatus = false.obs;
  var hasFetched = false.obs;
  late WebSocketChannel channelTask;
  var taskItemStatusUpdate = TaskItemStatusUpdate.fromJson(null).obs;

  var isLoad = false.obs;

  var order = Order.fromJson(null).obs;
  var task = DeliveryModel.fromJson(null).obs;

  Future setOrder(DeliveryModel deliveryObj) async {
    order.value = deliveryObj.order;
    task.value = deliveryObj;
    update();
    refreshOrder();
  }

  deleteCachedOrder() {
    order.value = Order.fromJson(null);
    update();
  }

  resetOrder() async {
    order.value = Order.fromJson(null);
    update();
  }

  Future refreshOrder() async {
    var url = "${Api.baseUrl}/orders/order/${order.value.id}";
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    // print(response?.body);
    // print(response?.statusCode);
    OrderController.instance.getOrdersByStatus();

    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }

    try {
      order.value = Order.fromJson(jsonDecode(responseData));
    } catch (e) {
      // print('error in order change status controller to refresh order $e');
    }
    isLoad.value = false;
    update();
  }

  getTaskItemSocket() {
    final wsUrlTask = Uri.parse('$websocketBaseUrl/orderStatus/');
    channelTask = WebSocketChannel.connect(wsUrlTask);
    channelTask.sink.add(jsonEncode({
      'user_id': UserController.instance.user.value.id,
      'order_id': order.value.id,
      'user_type': 'rider'
    }));

    Timer.periodic(const Duration(seconds: 10), (timer) {
      channelTask.sink.add(jsonEncode({
        'user_id': UserController.instance.user.value.id,
        'order_id': order.value.id,
        'user_type': 'rider'
      }));
    });

    channelTask.stream.listen((message) {
      log(message);
      taskItemStatusUpdate.value =
          TaskItemStatusUpdate.fromJson(jsonDecode(message));
      refreshOrder();
      if (hasFetched.value != true) {
        hasFetched.value = true;
      }
      update();
    });
  }

  updateTaskItemStatus({String query = ""}) async {
    try {
      isLoadUpdateStatus.value = true;
      update();

      var url = "${Api.baseUrl}${taskItemStatusUpdate.value.url}$query";
      final response = await http.get(
        Uri.parse(url),
        headers: authHeader(),
      );

      dynamic data = jsonDecode(response.body);

      if (response.statusCode.toString().startsWith('2')) {
        channelTask.sink.add(jsonEncode({
          'user_id': UserController.instance.user.value.id,
          'order_id': order.value.id,
          'user_type': 'rider'
        }));
        order.value = Order.fromJson(data);
        ApiProcessorController.successSnack("Updated successfully");
      } else {
        ApiProcessorController.errorSnack(data['detail']);
      }
    } on SocketException {
      ApiProcessorController.errorSnack(
          "No internet connection. Please check your network settings.");
    }
    isLoadUpdateStatus.value = false;
    update();
  }

  closeTaskSocket() {
    channelTask.sink.close(1000);
  }
}
