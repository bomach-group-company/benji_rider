// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import '../user_auth/userAuth.dart';

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

    Timer(
      Duration(seconds: 3),
      () {
        Get.offAll(
          () => const UserSnapshot(),
          duration: const Duration(seconds: 3),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "UserSnapshot",
          predicate: (route) => false,
          popGesture: true,
          transition: Transition.fadeIn,
        );
      },
    );
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
                      image:
                          AssetImage("assets/images/splash_screen/frame_1.png"),
                    ),
                  ),
                ),
                kSizedBox,
                Text(
                  'Rider App',
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 16,
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
  }
}
