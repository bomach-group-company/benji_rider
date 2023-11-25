// ignore_for_file: empty_catches

import 'package:benji_rider/app/auth/login.dart';
import 'package:benji_rider/app/dashboard/dashboard.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
  }

  // @override
  // void onInit() {
  //   checkAuth();
  //   super.onInit();
  // }

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
      Get.offAll(
        () => const Login(),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        routeName: "Login",
        predicate: (route) => false,
        popGesture: false,
        transition: Transition.cupertinoDialog,
      );
    }
  }
}
