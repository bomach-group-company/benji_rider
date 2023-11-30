// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/error_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/models/order_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderStatusChangeController extends GetxController {
  static OrderStatusChangeController get instance {
    return Get.find<OrderStatusChangeController>();
  }

  var isLoad = false.obs;

  var order = Order.fromJson(null).obs;

  deleteCachedOrders() {
    order.value = Order.fromJson(null);
  }

  resetOrders() async {
    order.value = Order.fromJson(null);
  }

  Future getOrderStatus(String orderId) async {
    isLoad.value = true;
    update();

    var url = "${Api.baseUrl}/orders/order/$orderId";

    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    print(response?.body);
    print(response?.statusCode);

    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }

    try {
      order.value = Order.fromJson(jsonDecode(responseData));
    } catch (e) {}
    isLoad.value = false;
    update();
  }

  Future setDispatched() async {}
  Future setDelivered() async {}
}
