import 'dart:convert';

import 'package:benji_rider/app/auth/login.dart';
import 'package:benji_rider/repo/models/user_model.dart';
import 'package:benji_rider/repo/utils/constants.dart';
import 'package:benji_rider/src/widget/section/my_floating_snackbar.dart';
import 'package:benji_rider/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUser(String user, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map data = jsonDecode(user);
  data['token'] = token;
  await prefs.setString('user', jsonEncode(data));
}

Future<User?> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? user = prefs.getString('user');
  if (user == null) {
    return null;
  }
  return modelUser(user);
}

Future<bool> deleteUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('isOnline');
  prefs.remove('isVisibleCash');
  prefs.remove('rememberMe');
  return prefs.remove('user');
}

// Future<Map<String, String>> authHeader([String? authToken]) async {
//   if (authToken == null) {
//     User? user = await getUser();
//     if (user != null) {
//       authToken = user.token;
//     }
//   }
//   return {
//     'Authorization': 'Bearer $authToken',
//     'Content-Type': 'application/json'
//   };
// }

dynamic isUnauthorized(Map data) {
  if (data.containsKey('detail') && data['detail'] == 'Unauthorized') {
    return Get.offAll(
      () => Login(),
      routeName: 'Login',
      predicate: (route) => false,
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  } else {
    return data;
  }
}

checkUserAuth() async {
  User? haveUser = await getUser();
  if (haveUser == null) {
    return Get.offAll(
      () => Login(
        logout: true,
      ),
      routeName: 'Login',
      predicate: (route) => false,
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }
}

checkAuth(context) async {
  User? haveUser = await getUser();
  bool? isAuth = await isAuthorized();
  if (isAuth == null) {
    mySnackBar(
      context,
      kAccentColor,
      "No Internet!",
      "Please Connect to the internet",
      Duration(seconds: 3),
    );
  }
  if (haveUser == null || isAuth == false) {
    mySnackBar(
      context,
      kAccentColor,
      "Login to continue!",
      "Please login to continue",
      Duration(seconds: 2),
    );
    return Get.offAll(
      () => Login(
        logout: true,
      ),
      routeName: 'Login',
      predicate: (route) => false,
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: false,
      transition: Transition.rightToLeft,
    );
  }
}

Future<Map<String, String>> authHeader(
    [String? authToken, String? contentType]) async {
  if (authToken == null) {
    User? user = await getUser();
    if (user != null) {
      authToken = user.token;
    }
  }

  Map<String, String> res = {
    'Authorization': 'Bearer $authToken',
  };
  // 'Content-Type': 'application/json', 'application/x-www-form-urlencoded'

  if (contentType != null) {
    res['Content-Type'] = contentType;
  }
  return res;
}

Future<bool?> isAuthorized() async {
  try {
    final response = await http.get(
      Uri.parse('$baseURL/auth/'),
      headers: await authHeader(),
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      if (data["detail"] == "Unauthorized") {
        return false;
      }
      return true;
    }
    return false;
  } catch (e) {
    return null;
  }
}
