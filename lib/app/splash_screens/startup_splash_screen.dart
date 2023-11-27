// ignore_for_file: file_names

import 'package:benji_rider/repo/controller/auth_controller.dart';
import 'package:benji_rider/repo/controller/delivery_history_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/controller/vendor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class StartupSplashscreen extends StatefulWidget {
  const StartupSplashscreen({super.key});

  @override
  State<StartupSplashscreen> createState() => _StartupSplashscreenState();
}

class _StartupSplashscreenState extends State<StartupSplashscreen> {
//=============================================== INITIAL STATE AND DISPOSE ===========================================================\\

  @override
  void initState() {
    super.initState();
    if (UserController.instance.ifUser()) {
      VendorController.instance.getVendorList();
      DeliveryHistoryController.instance.getDeliveryHistory();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
//==============================================================================================================\\

//=============================================== FUNCTIONS ===============================================================\\

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return Scaffold(
          body: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(kDefaultPadding),
            children: [
              SizedBox(
                height: mediaHeight,
                width: mediaWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: mediaHeight / 4,
                      width: mediaWidth / 2,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/splash_screen/frame_1.png"),
                        ),
                      ),
                    ),
                    kSizedBox,
                    Text(
                      'Rider App',
                      style: TextStyle(
                        color: kAccentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kSizedBox,
                    SpinKitThreeInOut(
                      color: kSecondaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
