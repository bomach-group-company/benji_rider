// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/vendor_model.dart';
import '../utils/helpers.dart';
import 'api_url.dart';

class BusinessController extends GetxController {
  static BusinessController get instance {
    return Get.find<BusinessController>();
  }

  var isLoading = false.obs;
  var total = 0.obs;
  var loadNum = 10.obs;
  var businesses = <VendorModel>[].obs;

  Future<void> getVendorList() async {
    isLoading.value = true;
    update();
    List<VendorModel> data = await getVendors();
    businesses.value = data;
    isLoading.value = false;
    update();
  }

  Future<List<VendorModel>> getVendors() async {
    var url =
        "${Api.baseUrl}${Api.getAllVendors}?start=${loadNum.value - 10}&end=${loadNum.value}";
    final response = await http.get(
      Uri.parse(url),
      headers: authHeader(),
    );
    if (response.statusCode == 200) {
      total.value = jsonDecode(response.body)['total'];
      update();
      log(response.body);
      return (jsonDecode(response.body)['items'] as List)
          .map((item) => VendorModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load vendor');
    }
  }
}
