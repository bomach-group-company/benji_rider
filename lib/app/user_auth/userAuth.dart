import 'package:benji_rider/app/auth/login.dart';
import 'package:benji_rider/app/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repo/models/user_model.dart';
import '../../repo/utils/helpers.dart';

class UserSnapshot extends StatelessWidget {
  static String routeName = "User Snapshot";
  const UserSnapshot({super.key});

  Future<User?> rememberUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rememberMe = prefs.getBool('rememberMe');
    if (rememberMe == false) {
      return null;
    }
    return getUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: Stream<User?>.fromFuture(rememberUser()),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return const Dashboard();
            } else {
              return const Login();
            }
          },
        ),
      );
}
