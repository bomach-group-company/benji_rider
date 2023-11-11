import 'package:benji_rider/repo/controller/auth_controller.dart';
import 'package:benji_rider/repo/controller/form_controller.dart';
import 'package:benji_rider/repo/controller/latlng_detail_controller.dart';
import 'package:benji_rider/repo/controller/login_controller.dart';
import 'package:benji_rider/repo/controller/notification_controller.dart';
import 'package:benji_rider/repo/controller/order_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/controller/vendor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/splash_screens/startup_splash_screen.dart';
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

  final user = Get.put(UserController());
  final login = Get.put(LoginController());
  final order = Get.put(OrderController());
  final form = Get.put(FormController());
  final latLngDetail = Get.put(LatLngDetailController());
  final notify = Get.put(NotificationController());
  final auth = Get.put(AuthController());
  final vendor = Get.put(VendorController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      debugShowCheckedModeBanner: false,
      title: "Benji Rider",
      color: kPrimaryColor,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: StartupSplashscreen(),
    );
  }
}
