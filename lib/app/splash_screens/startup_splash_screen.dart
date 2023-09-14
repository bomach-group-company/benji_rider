// ignore_for_file: file_names

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
    Future.delayed(const Duration(seconds: 3), () {
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
    });

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ListView(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: mediaHeight,
            width: mediaWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/splash_screen/frame_1.png",
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                kSizedBox,
                SpinKitThreeInOut(
                  color: kSecondaryColor,
                  size: 20
                ),
                kSizedBox,
                Text(
                  "Rider App",
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
