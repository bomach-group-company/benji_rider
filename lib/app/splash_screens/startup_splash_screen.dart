import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/account_controller.dart';
import '../../src/repo/controller/auth_controller.dart';
import '../../src/repo/controller/order_controller.dart';
import '../../src/repo/controller/user_controller.dart';
import '../../src/repo/controller/vendor_controller.dart';
import '../../src/repo/controller/withdraw_controller.dart';
import '../../theme/colors.dart';

class StartupSplashscreen extends StatefulWidget {
  StartupSplashscreen({super.key});

  final auth = Get.put(AuthController());

  @override
  State<StartupSplashscreen> createState() => _StartupSplashscreenState();
}

class _StartupSplashscreenState extends State<StartupSplashscreen> {
//=============================================== INITIAL STATE AND DISPOSE ===========================================================\\

  @override
  void initState() {
    super.initState();
    UserController.instance.ifUser().then((value) {
      if (value) {
        VendorController.instance.getVendorList();
        OrderController.instance.getOrdersByStatus();
        WithdrawController.instance.withdrawalHistory();
        AccountController.instance.getAccounts();
        WithdrawController.instance.listBanks();
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
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;

    return GetBuilder<AuthController>(
      initState: (state) => AuthController.instance.checkAuth(),
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
