// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_rider/main.dart';
import 'package:benji_rider/src/repo/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../app/auth/login.dart';
import '../../../app/dashboard/dashboard.dart';
import '../models/vendor_model.dart';
import '../utils/helpers.dart';
import 'api_url.dart';
import 'error_controller.dart';

class UserController extends GetxController {
  static UserController get instance {
    return Get.find<UserController>();
  }

  var isLoading = false.obs;
  var user = User.fromJson(null).obs;
  var vendor = VendorModel.fromJson(null).obs;

  @override
  void onInit() {
    setUserSync();
    super.onInit();
  }

  Future<bool> ifUser() async {
    if (!(await isAuthorized())) {
      return false;
    }
    return true;
  }

  Future checkAuth() async {
    if (await isAuthorized()) {
      Get.offAll(
        () => const Dashboard(),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Dashboard",
        predicate: (route) => false,
        popGesture: false,
        transition: Transition.cupertinoDialog,
      );
    } else {
      Get.offAll(() => const Login());
    }
  }

  Future<void> saveUser(String user, String token) async {
    Map data = jsonDecode(user);
    data['token'] = token;

    await prefs.setString('user', jsonEncode(data));
    setUserSync();
  }

  void setUserSync() {
    String? userData = prefs.getString('user');
    bool? isVisibleCash = prefs.getBool('isVisibleCash');
    if (userData == null) {
      user.value = User.fromJson(null);
    } else {
      Map<String, dynamic> userObj =
          (jsonDecode(userData) as Map<String, dynamic>);
      userObj['isVisibleCash'] = isVisibleCash;
      user.value = User.fromJson(userObj);
    }
    update();
  }

  Future<bool> deleteUser() async {
    return await prefs.remove('user');
  }

  getUser() async {
    isLoading.value = true;
    update();

    final user = UserController.instance.user.value;
    http.Response? responseUserData = await HandleData.getApi(
        '${Api.baseUrl}${Api.getSpecificRider}${user.id}/', user.token);
    if (responseUserData?.statusCode != 200) {
      ApiProcessorController.errorSnack("Failed to refresh");
      isLoading.value = false;
      update();
      return;
    }

    UserController.instance.saveUser(responseUserData!.body, user.token);
    isLoading.value = false;
    update();
  }
}
