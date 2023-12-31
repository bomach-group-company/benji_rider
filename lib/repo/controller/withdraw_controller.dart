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

  var isLoadWithdraw = false.obs;
  var isLoad = false.obs;
  var isLoadValidateAccount = false.obs;
  // var userId = UserController.instance.user.value.id;
  var listOfBanks = <BankModel>[].obs;
  var listOfBanksSearch = <BankModel>[].obs;
  var listOfWithdrawals = <WithdrawalHistoryModel>[].obs;
  var validateAccount = ValidateBankAccountModel.fromJson(null).obs;
  var noWithdrawalHistory = "".obs;

  searchBanks(String search) {
    listOfBanksSearch = listOfBanks;
    listOfBanksSearch.value =
        listOfBanksSearch.where((str) => str.name.contains(search)).toList();
    update();
  }

  makeWithdrawal(double amount) {
    final userId = UserController.instance.user.value.id;
  }

  listBanks() async {
    var url = "${Api.baseUrl}${Api.listBanks}";
    isLoad.value = true;
    update();
    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());
      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          listOfBanks.value =
              BankModel.listFromJson(jsonResponse.cast<Map<String, dynamic>>());
          listOfBanksSearch = listOfBanks;
        } else if (jsonResponse is Map) {
          if (jsonResponse.containsKey('items')) {
            listOfBanks.value = BankModel.listFromJson(
                jsonResponse['items'].cast<Map<String, dynamic>>());
            listOfBanksSearch = listOfBanks;
          } else {
            listOfBanks.value = [];
            listOfBanksSearch.value = [];
          }
        } else {
          listOfBanks.value = [];
          listOfBanksSearch.value = [];
        }
      } else {
        listOfBanks.value = [];
        listOfBanksSearch.value = [];
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    }
    isLoad.value = false;
    update();
  }

  Future<void> validateBankNumbers(
      String accountNumber, String bankCode) async {
    var url =
        "${Api.baseUrl}${Api.validateBankNumber}?account_number=$accountNumber&bank_code=$bankCode";
    print(url);
    isLoadValidateAccount.value = true;
    update();

    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());
      print(response.body);
      print(response.statusCode);

      if (response.statusCode != 200) {
        validateAccount.value = ValidateBankAccountModel.fromJson(null);
        return;
      }
      var responseData = jsonDecode(response.body);
      validateAccount.value = ValidateBankAccountModel.fromJson(
          responseData as Map<String, dynamic>);
      // responseData.map((item) => ValidateBankAccountModel.fromJson(item));
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e");
    }

    isLoadValidateAccount.value = false;
    update();
    return;
  }

  Future withdrawalHistory() async {
    var userId = UserController.instance.user.value.id;

    var url =
        "${Api.baseUrl}${Api.withdrawalHistory}?user_id=$userId&start=0&end=100";
    isLoad.value = true;
    update();

    try {
      final response = await http.get(Uri.parse(url), headers: authHeader());

      if (response.statusCode == 200) {
        try {
          List<WithdrawalHistoryModel> withdrawalHistoryList =
              (jsonDecode(response.body)['items'] as List)
                  .map((item) => WithdrawalHistoryModel.fromJson(item))
                  .toList();
          listOfWithdrawals.value = withdrawalHistoryList;
        } on SocketException {
          ApiProcessorController.errorSnack("Please connect to the internet");
        } catch (e) {
          ApiProcessorController.errorSnack(
              "An unexpected error occurred. \nERROR: $e");
          listOfWithdrawals.value = [];
        }
      } else {
        listOfWithdrawals.value = [];
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      ApiProcessorController.errorSnack(
          "An unexpected error occurred. \nERROR: $e");
    }

    isLoad.value = false;
    update();

    return;
  }

  Future<http.Response> withdraw(Map data) async {
    isLoadWithdraw.value = true;
    update();
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/wallet/requestRiderWithdrawal'),
      headers: authHeader(),
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      ApiProcessorController.errorSnack(
          'Balance too small or an error occured');
      isLoadWithdraw.value = false;
      update();
      return response;
    }

    ApiProcessorController.successSnack('Withdrawal successfully');
    isLoadWithdraw.value = false;
    update();
    return response;
  }
}
