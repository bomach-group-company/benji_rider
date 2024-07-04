import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../controller/user_controller.dart';

// API URLS AND HTTP CALL FUNCTIONS
const baseURL = "https://resource.bgbot.app/api/v1";
const baseImage = "https://resource.bgbot.app";

const String websocketBaseUrl = "ws://wsbenji.bgbot.app/ws";

// const String websocketBaseUrl =
//     "ws://127.0.0.1:6388/ws";

var vendorId = UserController.instance.user.value.id;

class Api {
  static const baseUrl = "https://resource.bgbot.app/api/v1";
  static const login = "/auth/token";
  static const user = "/auth/";
  static const changePassword = "/auth/changeNewPassword/";
  static const notification = "/vendors/";
  static const createSupport = "/drivers/CreateSupport";

//Businesses
  static const getSpecificRider = "/drivers/getRiderDetails/";
  static const getAllBusinesses = "/drivers/getAllBusinesses/";

  //order
  static const changeOrderStatus = "/orders/changeOrderStatus";

  //BusinessTypes
  static const businessType = "/categories/list";

  //Wallet
  static const getBanks = "/payments/list_banks/";
  static const withdrawalHistory = "/wallet/withdrawalHistory/";
  static const listWithdrawalHistories =
      "/withdrawalhistory/listWithdrawalHistories/";
  static const validateBankNumber = "/payments/validateBankNumbers/";
  static const saveBankDetails = "/payments/saveBankDetails";

  //Push Notification
  static const createPushNotification = "/notifier/create_push_notification";
}

String header = "application/json";
const content = "application/x-www-form-urlencoded";

class HandleData {
  static Future<http.Response?> postApi([
    String? url,
    String? token,
    dynamic body,
  ]) async {
    http.Response? response;
    try {
      if (token == null) {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
                "Content-Type": content,
              },
              body: body,
            )
            .timeout(const Duration(seconds: 20));
      } else {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
                "Content-Type": content,
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
              body: jsonEncode(body),
            )
            .timeout(const Duration(seconds: 20));
      }
    } catch (e) {
      response = null;
    }
    return response;
  }

  static Future<http.Response?> getApi([
    String? url,
    String? token,
  ]) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(url!),
        headers: {
          HttpHeaders.contentTypeHeader: header,
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
    } catch (e) {
      response = null;
    }
    return response;
  }

  static Future put() async {}
  static Future delete() async {}
}

consoleLog(String val) {
  return debugPrint(val);
}
