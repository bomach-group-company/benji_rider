import 'package:benji_rider/src/repo/controller/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/splash_screens/startup_splash_screen.dart';
import 'firebase_options.dart';
import 'src/repo/controller/account_controller.dart';
import 'src/repo/controller/business_controller.dart';
import 'src/repo/controller/delivery_history_controller.dart';
import 'src/repo/controller/fcm_messaging_controller.dart';
import 'src/repo/controller/form_controller.dart';
import 'src/repo/controller/latlng_detail_controller.dart';
import 'src/repo/controller/login_controller.dart';
import 'src/repo/controller/notification_controller.dart';
import 'src/repo/controller/order_controller.dart';
import 'src/repo/controller/order_status_change.dart';
import 'src/repo/controller/package_controller.dart';
import 'src/repo/controller/push_notifications_controller.dart';
import 'src/repo/controller/tasks_controller.dart';
import 'src/repo/controller/user_controller.dart';
import 'src/repo/controller/withdraw_controller.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

late SharedPreferences prefs;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kTransparentColor),
  );

  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  Get.put(FcmMessagingController());

  Get.put(UserController());
  Get.put(LoginController());
  Get.put(OrderController());
  Get.put(FormController());
  Get.put(LatLngDetailController());
  Get.put(NotificationController());
  Get.put(BusinessController());
  Get.put(TasksController());
  Get.put(WithdrawController());
  Get.put(DeliveryHistoryController());
  Get.put(AccountController());
  Get.put(OrderStatusChangeController());
  Get.put(PackageController());
  Get.put(PushNotificationController());
  Get.put(AuthController());

  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await PushNotificationController.initializeNotification();
  }

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
