// ignore_for_file: empty_catches

import 'package:benji_rider/repo/models/vendor_model.dart';
import 'package:get/get.dart';

class VendorController extends GetxController {
  static VendorController get instance {
    return Get.find<VendorController>();
  }

  var isLoading = false.obs;
  var vendors = <VendorModel>[].obs;

  Future<void> getVendorList() async {
    isLoading.value = true;
    update();
    List<VendorModel> data = await getVendors();
    vendors.value = data;
    isLoading.value = false;
    update();
  }
}
