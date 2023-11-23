// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:benji_rider/repo/models/vendor_model.dart';
import 'package:benji_rider/repo/utils/constants.dart';
import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VendorController extends GetxController {
  static VendorController get instance {
    return Get.find<VendorController>();
  }

  var isLoading = false.obs;
  var total = 0.obs;
  var vendors = <VendorModel>[].obs;

  Future<void> getVendorList() async {
    isLoading.value = true;
    update();
    List<VendorModel> data = await getVendors();
    vendors.value = data;
    isLoading.value = false;
    update();
  }

  Future<List<VendorModel>> getVendors({start = 1, end = 10}) async {
    final response = await http.get(
      Uri.parse('$baseURL/vendors/getAllVendor?start=$start&end=$end'),
      headers: authHeader(),
    );
    if (response.statusCode == 200) {
      total.value = jsonDecode(response.body)['total'];
      update();
      return (jsonDecode(response.body)['items'] as List)
          .map((item) => VendorModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load vendor');
    }
  }
}
