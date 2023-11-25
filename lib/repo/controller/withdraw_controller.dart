import 'dart:convert';
import 'dart:io';

import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/error_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/repo/models/validate_bank_account.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/bank_model.dart';
import '../models/withdrawal_history_model.dart';
import '../utils/helpers.dart';

class WithdrawController extends GetxController {
  static WithdrawController get instance {
    return Get.find<WithdrawController>();
  }

  bool? isFirst;
  WithdrawController({this.isFirst});
  var isLoad = false.obs;
  var userId = UserController.instance.user.value.id;
  var listOfBanks = <BankModel>[].obs;
  var listOfWithdrawals = <WithdrawalHistoryModel>[].obs;
  var validateAccount = ValidateBankAccountModel.fromJson(null).obs;
  var noWithdrawalHistory = "".obs;

  listBanks() async {
    var url = "${Api.baseUrl}${Api.listBanks}";
    consoleLog(url);
    isLoad.value = true;
    update();
    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());

      if (response.statusCode == 200) {
        consoleLog(response.body);
        dynamic jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          listOfBanks.value =
              BankModel.listFromJson(jsonResponse.cast<Map<String, dynamic>>());
        } else if (jsonResponse is Map) {
          if (jsonResponse.containsKey('items')) {
            listOfBanks.value = BankModel.listFromJson(
                jsonResponse['items'].cast<Map<String, dynamic>>());
          } else {
            listOfBanks.value = [];
          }
        } else {
          listOfBanks.value = [];
        }
      } else {
        listOfBanks.value = [];
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog(e.toString());
    }
    isLoad.value = false;
    update();
  }

  Future<void> validateBankNumbers(
      String accountNumber, String bankCode) async {
    var url =
        "${Api.baseUrl}${Api.validateBankNumber}?account_number=$accountNumber&bank_code=$bankCode";
    consoleLog(url);

    isLoad.value = true;
    update();

    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());

      if (response.statusCode != 200) {
        consoleLog(response.body);
        validateAccount.value = ValidateBankAccountModel.fromJson(null);
        return;
      }
      var responseData = jsonDecode(response.body);
      consoleLog("This is the response body: ${response.body}");
      consoleLog("This is the response data: $responseData");
      validateAccount.value = ValidateBankAccountModel.fromJson(
          responseData as Map<String, dynamic>);
      // responseData.map((item) => ValidateBankAccountModel.fromJson(item));
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog("Error parsing JSON: $e");
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e");
    }

    isLoad.value = false;
    update();
    return;
  }

  Future withdrawalHistory() async {
    var url = "${Api.baseUrl}${Api.withdrawalHistory}?user_id=$userId";
    isLoad.value = true;
    update();

    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());

      if (response.statusCode == 200) {
        consoleLog(response.body);

        if (response.body == '"user histories not found."' ||
            (jsonDecode(response.body) as List).isEmpty) {
          noWithdrawalHistory.value = response.body;
        } else {
          try {
            List<dynamic> jsonResponse = jsonDecode(response.body);

            List<WithdrawalHistoryModel> withdrawalHistoryList = jsonResponse
                .map((item) => WithdrawalHistoryModel.fromJson(item))
                .toList();
            listOfWithdrawals.value = withdrawalHistoryList;
          } on SocketException {
            ApiProcessorController.errorSnack("Please connect to the internet");
          } catch (e) {
            consoleLog("Error parsing JSON: $e");
            ApiProcessorController.errorSnack(
                "An unexpected error occurred. \nERROR: $e");
            listOfWithdrawals.value = [];
          }
        }
      } else {
        listOfWithdrawals.value = [];
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      consoleLog("Error parsing JSON: $e");
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e");
    }

    isLoad.value = false;
    update();

    return;
  }
}
