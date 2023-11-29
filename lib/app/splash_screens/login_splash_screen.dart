// ignore_for_file: camel_case_types, file_names

import 'dart:async';

import 'package:benji_rider/app/dashboard/dashboard.dart';
import 'package:benji_rider/repo/controller/account_controller.dart';
import 'package:benji_rider/repo/controller/delivery_history_controller.dart';
import 'package:benji_rider/repo/controller/order_controller.dart';
import 'package:benji_rider/repo/controller/vendor_controller.dart';
import 'package:benji_rider/repo/controller/withdraw_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../../theme/colors.dart';

class LoginSplashScreen extends StatefulWidget {
  const LoginSplashScreen({super.key});

  @override
  State<LoginSplashScreen> createState() => _LoginSplashScreenState();
}

class _LoginSplashScreenState extends State<LoginSplashScreen> {
  @override
  void initState() {
    super.initState();
    VendorController.instance.getVendorList();
    OrderController.instance.getOrdersByStatus();

    // DeliveryHistoryController.instance.getDeliveryHistory();
    AccountController.instance.getAccounts();
    WithdrawController.instance.listBanks();

    Timer(
      const Duration(seconds: 2),
      () {
        Get.off(
          () => const Dashboard(),
          routeName: 'Dashboard',
          duration: const Duration(milliseconds: 300),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          preventDuplicates: true,
          popGesture: true,
          transition: Transition.fadeIn,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Center(
              child: Lottie.asset(
                "assets/animations/login/frame_1.json",
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
