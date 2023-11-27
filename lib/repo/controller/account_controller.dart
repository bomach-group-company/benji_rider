import 'dart:convert';
import 'dart:io';

import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/error_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/models/account_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/helpers.dart';

class AccountController extends GetxController {
  static AccountController get instance {
    return Get.find<AccountController>();
  }

  AccountController();
  var isLoad = false.obs;
  var userId = UserController.instance.user.value.id;
  var accounts = <AccountModel>[].obs;

  getAccounts() async {
    var url = "${Api.baseUrl}/payments/getSaveBankDetails/$userId/";
    consoleLog(url);
    isLoad.value = true;
    update();
    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());

      if (response.statusCode == 200) {
        consoleLog(response.body);
        dynamic jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          accounts.value = AccountModel.listFromJson(
              jsonResponse.cast<Map<String, dynamic>>());
        } else if (jsonResponse is Map) {
          if (jsonResponse.containsKey('items')) {
            accounts.value = AccountModel.listFromJson(
                (jsonResponse['items'] as List).cast<Map<String, dynamic>>());
          } else {
            accounts.value = [];
          }
        } else {
          accounts.value = [];
        }
      } else {
        accounts.value = [];
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
    }
    isLoad.value = false;
    update();
  }
}
