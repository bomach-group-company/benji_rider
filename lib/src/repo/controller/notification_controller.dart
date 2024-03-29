// ignore_for_file: empty_catches

import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/notificatin_model.dart';
import 'api_url.dart';
import 'error_controller.dart';
import 'user_controller.dart';

class NotificationController extends GetxController {
  static NotificationController get instance {
    return Get.find<NotificationController>();
  }

  var isLoad = false.obs;
  var notification = <NotificationModel>[].obs;
  Future runTask() async {
    isLoad.value = true;
    late String token;
    update();

    var url =
        "${Api.baseUrl}${Api.notification}${UserController.instance.user.value.id}/getVendorNotifications";

    token = UserController.instance.user.value.token;

    try {
      http.Response? response = await HandleData.getApi(url, token);
      var responseData = await ApiProcessorController.errorState(response);
      var save = notificationModelFromJson(responseData);
      notification.value = save;
      update();
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      ApiProcessorController.errorSnack(
          "Could not load notifications. ERROR: $e");
    }
    isLoad.value = false;

    update();
  }
}
