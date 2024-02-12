// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../app/splash_screens/login_splash_screen.dart';
import 'api_url.dart';
import 'error_controller.dart';
import 'login_model.dart';
import 'user_controller.dart';

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

      // http.Response? response =
      //     await HandleData.postApi(Api.baseUrl + Api.login, null, finalData);
      final response = await http
          .post(
            Uri.parse(Api.baseUrl + Api.login),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              "Content-Type": "application/x-www-form-urlencoded",
            },
            body: finalData,
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        ApiProcessorController.errorSnack(
            "Invalid email or password. Try again");
        isLoad.value = false;
        update();
        return;
      }

      var responseData = jsonDecode(response.body);
      if (responseData["token"] == false) {
        ApiProcessorController.errorSnack(
            "Invalid email or password. Try again");
        isLoad.value = false;
        update();
      } else {
        // http.Response? responseUser = await HandleData.getApi(
        //     Api.baseUrl + Api.user, responseData["token"]);
        final responseUser = await http.get(
          Uri.parse(Api.baseUrl + Api.user),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${responseData["token"]}",
          },
        );
        if (responseUser.statusCode != 200) {
          ApiProcessorController.errorSnack(
              "Invalid email or password. Try again");
          isLoad.value = false;
          update();
          return;
        }

        // http.Response? responseUserData = await HandleData.getApi(
        //     '${Api.baseUrl}${Api.getSpecificRider}${jsonDecode(responseUser?.body ?? '{}')['id']}/',
        //     responseData["token"]);

        final responseUserData = await http.get(
          Uri.parse(
              '${Api.baseUrl}${Api.getSpecificRider}${jsonDecode(responseUser.body)['id']}/'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer ${responseData["token"]}",
          },
        );

        if (responseUserData.statusCode != 200) {
          ApiProcessorController.errorSnack(
              "Invalid email or password. Try again");
          isLoad.value = false;
          update();
          return;
        }

        await UserController.instance
            .saveUser(responseUserData.body, responseData["token"]);
        isLoad.value = false;
        update();
        ApiProcessorController.successSnack("Login Successful");
        Get.offAll(
          () => const LoginSplashScreen(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "LoginSplashScreen",
          predicate: (route) => false,
          popGesture: true,
          transition: Transition.cupertinoDialog,
        );
        return;
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
      isLoad.value = false;
      update();
    } catch (e) {
      ApiProcessorController.errorSnack("Invalid email or password. Try again");
      isLoad.value = false;
      update();
    }
  }
}
