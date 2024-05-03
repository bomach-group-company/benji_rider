// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
    // print(response?.body);
    // print(response?.statusCode);
    // PackageController.instance.getPackagesByStatus();

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

  orderDelivered(String packageCode) async {
    isLoad.value = true;
    update();

    var url =
        "${Api.baseUrl}/sendPackage/packageUserStatus/${package.value.id}/$packageCode";
    // await FormController.instance.getAuth(url, 'orderDelivered');

    final user = UserController.instance.user.value;
    http.Response? response = await HandleData.getApi(url, user.token);
    // var responseData = await ApiProcessorController.errorState(response);
    // print('response?.body package ${response?.body}');
    try {
      final data = (jsonDecode(response!.body) as Map);
      // print('passed the first one');
      if (data['message'] == null && response.statusCode == 200) {
        ApiProcessorController.successSnack('Package delivered success');
      }
      ApiProcessorController.errorSnack(data['message']);
    } catch (e) {
      ApiProcessorController.errorSnack('An error occured');
    }

    isLoad.value = false;
    update();
    // print(FormController.instance.status);

    // if (FormController.instance.status.toString().startsWith('2')) {
    //   // await orderDelivered();
    // } else {
    //   ApiProcessorController.errorSnack('An error occured');
    // }
    // await refreshPackage();
    await refreshPackage();
  }

  orderDispatched() async {
    isLoad.value = true;
    update();

    var url =
        "${Api.baseUrl}/sendPackage/riderReceiveStatus/${package.value.id}";
    await FormController.instance.getAuth(url, 'dispatchPackage');
    // print(FormController.instance.status);

    if (FormController.instance.status.toString().startsWith('2')) {}
    await refreshPackage();
  }

  packagePayment() async {
    isLoad.value = true;
    final user = UserController.instance.user.value;
    update();

    var url =
        "${Api.baseUrl}/drivers/completeMyPackageTask/${task.value.id}/${user.id}";

    await FormController.instance.getAuth(url, 'taskPayment');

    if (FormController.instance.status.toString().startsWith('2')) {
      ApiProcessorController.successSnack('Withdrawal successful');
    } else {
      ApiProcessorController.errorSnack(
          'Either you have already withdrawn or an error occured');
    }
  }
}
