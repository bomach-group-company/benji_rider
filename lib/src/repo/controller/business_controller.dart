// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/business_model.dart';
import '../utils/helpers.dart';
import 'api_url.dart';
import 'error_controller.dart';

class BusinessController extends GetxController {
  static BusinessController get instance {
    return Get.find<BusinessController>();
  }

  var isLoad = false.obs;
  var isLoadBalance = false.obs;
  var businesses = <BusinessModel>[].obs;
  var balance = 0.0.obs;

  var loadedAll = false.obs;
  var isLoadMore = false.obs;
  var loadNum = 10.obs;

  Future<void> scrollListener(scrollController) async {
    if (BusinessController.instance.loadedAll.value) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      BusinessController.instance.isLoadMore.value = true;
      update();
      await BusinessController.instance.getAllBusinesses();
    }
  }

  refreshData() {
    loadedAll.value = false;
    loadNum.value = 10;
    businesses.value = [];
    getAllBusinesses();
  }

  Future<void> getAllBusinesses() async {
    isLoad.value = true;

    String url =
        "${Api.baseUrl}${Api.getAllBusinesses}?start=${loadNum.value - 10}&end=${loadNum.value}";
    loadNum.value += 10;
    log(url);
    var parsedURL = Uri.parse(url);

    List<BusinessModel> data = [];
    try {
      var response = await http.get(
        parsedURL,
        headers: authHeader(),
      );
      print(response.body);

      if (response.body.isEmpty) {
        isLoad.value = false;
        loadedAll.value = true;
        isLoadMore.value = false;
        update();
        return;
      }

      if (response.statusCode == 200) {
        data = (jsonDecode(response.body) as List)
            .map((item) => BusinessModel.fromJson(item))
            .toList();
        businesses.value += data;
      } else {
        log(response.statusCode.toString());
        ApiProcessorController.errorSnack("An error occured, please refresh.");
      }
    } on SocketException {
      ApiProcessorController.errorSnack("Please connect to the internet");
    } catch (e) {
      log(e.toString());
    }
    loadedAll.value = data.isEmpty;
    isLoadMore.value = false;
    isLoad.value = false;
    update();
  }
}
