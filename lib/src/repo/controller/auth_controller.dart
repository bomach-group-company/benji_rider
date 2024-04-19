// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/auth/login.dart';
import '../../../app/dashboard/dashboard.dart';
import '../utils/helpers.dart';

class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
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
