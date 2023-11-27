// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/error_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/models/order_model.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum StatusType { delivered, pending, cancelled }

class OrderController extends GetxController {
  static OrderController get instance {
    return Get.find<OrderController>();
  }

  var isLoad = false.obs;
  var vendorsOrderList = <Order>[].obs;

  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;
  var total = 0.obs;
  var status = StatusType.delivered.obs;

  deleteCachedOrders() {
    vendorsOrderList.value = <Order>[];
    loadedAll.value = false;
    isLoadMore.value = false;
    loadNum.value = 10;
    total.value = 0;
    status.value = StatusType.delivered;
  }

  resetOrders() async {
    vendorsOrderList.value = <Order>[];
    loadedAll.value = false;
    isLoadMore.value = false;
    loadNum.value = 10;
    total.value = 0;
    status.value = StatusType.pending;
    setStatus();
  }

  Future<void> scrollListener(scrollController) async {
    if (OrderController.instance.loadedAll.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      OrderController.instance.isLoadMore.value = true;
      update();
      await OrderController.instance.getOrdersByStatus();
    }
  }

  setStatus([StatusType newStatus = StatusType.delivered]) async {
    status.value = newStatus;
    vendorsOrderList.value = [];
    loadNum.value = 10;
    loadedAll.value = false;
    update();
    await getOrdersByStatus();
  }

  Future getTotal() async {
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrders?start=0&end=1";
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);

    try {
      total.value =
          jsonDecode(response?.body ?? ({'total': 0}).toString())['total'];
    } catch (e) {
      total.value = 0;
      consoleLog(e.toString());
    }
    update();
  }

  Future getOrdersByStatus() async {
    if (loadedAll.value) {
      return;
    }
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}${Api.vendorsOrderList}$id/listMyOrdersByStatus?status=${statusTypeConverter(status.value)}&start=0&end=100";
    consoleLog(url);
    loadNum.value += 10;
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    consoleLog(response!.body);
    if (responseData == null) {
      isLoad.value = false;
      loadedAll.value = true;
      isLoadMore.value = false;
      update();
      return;
    }
    List<Order> data = [];
    try {
      data = (jsonDecode(responseData)['items'] as List)
          // data = (jsonDecode(responseData) as List)
          .map((e) => Order.fromJson(e))
          .toList();
      consoleLog(data.toString());
      vendorsOrderList.value += data;
    } catch (e) {
      consoleLog(e.toString());
    }
    loadedAll.value = data.isEmpty;
    isLoad.value = false;
    isLoadMore.value = false;
    update();
  }
}
