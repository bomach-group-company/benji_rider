// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:benji_rider/src/repo/models/task_item_status_update.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/delivery_model.dart';
import '../models/package.dart';
import '../utils/helpers.dart';
import 'api_url.dart';
import 'error_controller.dart';
import 'form_controller.dart';
import 'order_controller.dart';
import 'user_controller.dart';

class PackageController extends GetxController {
  static PackageController get instance {
    return Get.find<PackageController>();
  }

  var isLoadUpdateStatus = false.obs;
  var hasFetched = false.obs;
  late WebSocketChannel channelTask;
  var taskItemStatusUpdate = TaskItemStatusUpdate.fromJson(null).obs;

  var isLoad = false.obs;
  var vendorsOrderList = <DeliveryModel>[].obs;
  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;
  var total = 0.obs;
  var status = StatusType.processing.obs;

  var package = Package.fromJson(null).obs;
  var task = DeliveryModel.fromJson(null).obs;

  setStatus([StatusType newStatus = StatusType.delivered]) async {
    status.value = newStatus;
    vendorsOrderList.value = [];
    loadNum.value = 10;
    loadedAll.value = false;
    update();
    await getOrdersByStatus();
  }

  Future setPackage(DeliveryModel deliveryObj) async {
    package.value = deliveryObj.package;
    task.value = deliveryObj;
    update();
    refreshPackage();
  }

  deleteCachedPackage() {
    package.value = Package.fromJson(null);
    update();
  }

  resetPackage() async {
    package.value = Package.fromJson(null);
    update();
  }

  Future refreshPackage() async {
    var url =
        "${Api.baseUrl}/sendPackage/gettemPackageById/${package.value.id}/";
    String token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);

    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }

    try {
      package.value = Package.fromJson(jsonDecode(responseData));
    } catch (e) {
      // print('error in package change status controller to refresh package $e');
    }
    isLoad.value = false;
    update();
  }

  Future getOrdersByStatus() async {
    isLoad.value = true;
    late String token;
    String id = UserController.instance.user.value.id.toString();
    var url =
        "${Api.baseUrl}/tasks/getPackageTaskByStatus/$id/${statusTypeConverter(status.value)}";
    // print(url);
    token = UserController.instance.user.value.token;
    http.Response? response = await HandleData.getApi(url, token);
    var responseData = await ApiProcessorController.errorState(response);
    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }
    // print(response?.body);

    List<DeliveryModel> data = [];
    try {
      data = (jsonDecode(responseData) as List)
          .map((e) => DeliveryModel.fromJson(e))
          .toList();
      vendorsOrderList.value = data;
    } catch (e) {}
    isLoad.value = false;
    update();
  }

  getTaskItemSocket() {
    final wsUrlTask = Uri.parse('$websocketBaseUrl/packageStatus/');
    channelTask = WebSocketChannel.connect(wsUrlTask);
    channelTask.sink.add(jsonEncode({
      'user_id': UserController.instance.user.value.id,
      'package_id': package.value.id,
      'user_type': 'rider'
    }));

    Timer.periodic(const Duration(seconds: 10), (timer) {
      channelTask.sink.add(jsonEncode({
        'user_id': UserController.instance.user.value.id,
        'package_id': package.value.id,
        'user_type': 'rider'
      }));
    });

    channelTask.stream.listen((message) {
      log(message);
      taskItemStatusUpdate.value =
          TaskItemStatusUpdate.fromJson(jsonDecode(message));
      if (hasFetched.value != true) {
        hasFetched.value = true;
      }
      update();
    });
  }

  updateTaskItemStatus({String query = ""}) async {
    isLoadUpdateStatus.value = true;
    update();

    var url = "${Api.baseUrl}${taskItemStatusUpdate.value.url}$query";
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: authHeader(),
    );
    print(response.body);
    dynamic data = jsonDecode(response.body);

    if (response.statusCode.toString().startsWith('2')) {
      channelTask.sink.add(jsonEncode({
        'user_id': UserController.instance.user.value.id,
        'package_id': package.value.id,
        'user_type': 'rider'
      }));
      package.value = Package.fromJson(data);
      ApiProcessorController.successSnack("Updated successfully");
    } else {
      ApiProcessorController.errorSnack(data['detail']);
    }
    isLoadUpdateStatus.value = false;
    update();
  }
}
