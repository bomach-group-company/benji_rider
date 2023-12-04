import 'package:benji_rider/app/splash_screens/startup_splash_screen.dart';
import 'package:benji_rider/repo/controller/account_controller.dart';
import 'package:benji_rider/repo/controller/auth_controller.dart';
import 'package:benji_rider/repo/controller/delivery_history_controller.dart';
import 'package:benji_rider/repo/controller/form_controller.dart';
import 'package:benji_rider/repo/controller/latlng_detail_controller.dart';
import 'package:benji_rider/repo/controller/login_controller.dart';
import 'package:benji_rider/repo/controller/notification_controller.dart';
import 'package:benji_rider/repo/controller/order_controller.dart';
import 'package:benji_rider/repo/controller/order_status_change.dart';
import 'package:benji_rider/repo/controller/package_controller.dart';
import 'package:benji_rider/repo/controller/tasks_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/controller/vendor_controller.dart';
import 'package:benji_rider/repo/controller/withdraw_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/app_theme.dart';
import 'theme/colors.dart';

late SharedPreferences prefs;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kTransparentColor),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  prefs = await SharedPreferences.getInstance();

  Get.put(UserController());
  Get.put(AuthController());
  Get.put(LoginController());
  Get.put(OrderController());
  Get.put(FormController());
  Get.put(LatLngDetailController());
  Get.put(NotificationController());
  Get.put(VendorController());
  Get.put(TasksController());
  Get.put(WithdrawController());
  Get.put(DeliveryHistoryController());
  Get.put(AccountController());
  Get.put(OrderStatusChangeController());
  Get.put(PackageController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      title: "Benji Rider",
      color: kPrimaryColor,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: const StartupSplashscreen(),
    );
  }
}
