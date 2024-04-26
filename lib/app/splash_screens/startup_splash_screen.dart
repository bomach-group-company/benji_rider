import 'package:benji_rider/src/repo/controller/fcm_messaging_controller.dart';
import 'package:benji_rider/src/repo/controller/package_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/account_controller.dart';
import '../../src/repo/controller/auth_controller.dart';
import '../../src/repo/controller/order_controller.dart';
import '../../src/repo/controller/user_controller.dart';
import '../../src/repo/controller/withdraw_controller.dart';
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
    FcmMessagingController.instance.handleFCM();

    UserController.instance.ifUser().then((value) {
      if (value) {
        OrderController.instance.getOrdersByStatus();
        PackageController.instance.getOrdersByStatus();

        AccountController.instance.getAccounts();
        WithdrawController.instance.getBanks();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
//==============================================================================================================\\

//=============================================== FUNCTIONS ===============================================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return GetBuilder<AuthController>(
      initState: (state) => AuthController.instance.checkAuth(),
      builder: (controller) {
        return Scaffold(
          body: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(kDefaultPadding),
            children: [
              SizedBox(
                height: media.height,
                width: media.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: media.height / 4,
                      width: media.width / 2,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/splash_screen/frame_1.png",
                          ),
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
