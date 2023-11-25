// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:benji_rider/app/dashboard/dashboard.dart';
import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/error_controller.dart';
import 'package:benji_rider/repo/controller/login_model.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  static LoginController get instance {
    return Get.find<LoginController>();
  }

  var isLoad = false.obs;

  Future<void> login(SendLogin data) async {
    try {
      UserController.instance;
      isLoad.value = true;
      update();
      Map<String, dynamic> finalData = {
        "username": data.username,
        "password": data.password,
      };

      http.Response? response =
          await HandleData.postApi(Api.baseUrl + Api.login, null, finalData);

      consoleLog(finalData.toString());
      consoleLog(Api.baseUrl + Api.login);
      if (response!.statusCode != 200) {
        ApiProcessorController.errorSnack(
            "Invalid email or password. Try again");
        isLoad.value = false;
        update();
        return;
      }

      var responseData = jsonDecode(response.body);
      consoleLog("This is the response: $responseData");
      // debugPrint(responseData);
      if (responseData["token"] == false) {
        ApiProcessorController.errorSnack(
            "Invalid email or password. Try again");
        isLoad.value = false;
        update();
      } else {
        http.Response? responseUser = await HandleData.getApi(
            Api.baseUrl + Api.user, responseData["token"]);
        if (responseUser?.statusCode != 200) {
          ApiProcessorController.errorSnack(
              "Invalid email or password. Try again");
          isLoad.value = false;
          update();
          return;
        }

        http.Response? responseUserData = await HandleData.getApi(
            '${Api.baseUrl}${Api.getSpecificRider}${jsonDecode(responseUser?.body ?? '{}')['id']}/',
            responseData["token"]);
        debugPrint("${responseUserData?.statusCode}");

        if (responseUserData?.statusCode != 200) {
          ApiProcessorController.errorSnack(
              "Invalid email or password. Try again");
          isLoad.value = false;
          update();
          return;
        }
        debugPrint('almost');

        UserController.instance
            .saveUser(responseUserData?.body ?? '', responseData["token"]);
        isLoad.value = false;
        update();
        ApiProcessorController.successSnack("Login Successful");
        Get.offAll(
          () => const Dashboard(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "Dashboard",
          predicate: (route) => false,
          popGesture: true,
          transition: Transition.cupertinoDialog,
        );
        return;
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog("This is the error: $e");
      ApiProcessorController.errorSnack("Invalid email or password. Try again");
      isLoad.value = false;
      update();
    }
  }
}
