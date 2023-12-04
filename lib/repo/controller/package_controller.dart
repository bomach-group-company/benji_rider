// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/error_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/models/delivery_model.dart';
import 'package:benji_rider/repo/models/package.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PackageController extends GetxController {
  static PackageController get instance {
    return Get.find<PackageController>();
  }

  var isLoad = false.obs;

  var package = Package.fromJson(null).obs;

  var task = DeliveryModel.fromJson(null).obs;

  setPackage(DeliveryModel deliveryObj) async {
    package.value = deliveryObj.package;
    task.value = deliveryObj;
    update();
    await refreshPackage();
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
    print(response?.body);
    print(response?.statusCode);
    // PackageController.instance.getPackagesByStatus();

    if (responseData == null) {
      isLoad.value = false;
      update();
      return;
    }

    try {
      package.value = Package.fromJson(jsonDecode(responseData));
    } catch (e) {
      print('error in package change status controller to refresh package $e');
    }
    isLoad.value = false;
    update();
  }

  // packageDispatched() async {
  //   isLoad.value = true;
  //   update();

  //   var url =
  //       "${Api.baseUrl}/packages/RiderToVendorChangeStatus?package_id=${package.value.id}";
  //   await FormController.instance.getAuth(url, 'dispatchPackage');
  //   print(FormController.instance.status);

  //   if (FormController.instance.status.toString().startsWith('2')) {}
  //   await refreshPackage();
  // }

  // packageDelivered() async {
  //   isLoad.value = true;

  //   update();
  //   var url =
  //       "${Api.baseUrl}/packages/RiderToUserChangeStatus?package_id=${package.value.id}";
  //   await FormController.instance.getAuth(url, 'deliveredPackage');
  //   print(FormController.instance.status);
  //   if (FormController.instance.status.toString().startsWith('2')) {}
  //   await refreshPackage();
  // }
}
