import 'package:benji_rider/app/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveAuthToken(String authToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', authToken);
}

Future<String?> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

Future<bool> deleteAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove('auth_token');
}

Future<Map<String, String>> authHeader() async {
  String? authToken = await getAuthToken();
  return {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json'
  };
}

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
