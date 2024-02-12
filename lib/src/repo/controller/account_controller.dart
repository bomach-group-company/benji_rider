import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/account_model.dart';
import '../utils/helpers.dart';
import 'api_url.dart';
import 'error_controller.dart';
import 'user_controller.dart';

class AccountController extends GetxController {
  static AccountController get instance {
    return Get.find<AccountController>();
  }

  var isLoad = false.obs;
  var accounts = <AccountModel>[].obs;

  getAccounts() async {
    var userId = UserController.instance.user.value.id;
    var url = "${Api.baseUrl}/payments/getSaveBankDetails/$userId/";
    isLoad.value = true;
    update();
    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        accounts.value = AccountModel.listFromJson(
            (jsonResponse as List).cast<Map<String, dynamic>>());
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      accounts.value = [];
    }
    isLoad.value = false;
    update();
  }
}
