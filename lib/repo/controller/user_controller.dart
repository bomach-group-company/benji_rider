// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_rider/app/auth/login.dart';
import 'package:benji_rider/app/dashboard/dashboard.dart';
import 'package:benji_rider/main.dart';
import 'package:benji_rider/repo/models/user_model.dart';
import 'package:benji_rider/repo/models/vendor_model.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  bool ifUser() {
    String? userData = prefs.getString('user');
    return userData != null;
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
    if (userData == null) {
      user.value = User.fromJson(null);
    } else {
      user.value = User.fromJson(jsonDecode(userData) as Map<String, dynamic>);
    }
    update();
  }

  Future<bool> deleteUser() async {
    return await prefs.remove('user');
  }
}
