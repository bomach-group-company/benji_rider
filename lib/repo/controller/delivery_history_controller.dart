// ignore_for_file: empty_catches


import 'package:benji_rider/repo/models/delivery_model.dart';
import 'package:get/get.dart';

class DeliveryHistoryController extends GetxController {
  static DeliveryHistoryController get instance {
    return Get.find<DeliveryHistoryController>();
  }

  var isLoad = false.obs;
  var deliveryList = <DeliveryModel>[].obs;

  deleteCachedDeliveryHistory() {
    deliveryList.value = <DeliveryModel>[];
  }

  // Future getDeliveryHistory() async {
  //   isLoad.value = true;
  //   late String token;
  //   String id = UserController.instance.user.value.id.toString();
  //   var url =
  //       "${Api.baseUrl}/drivers/completeDeliveryRequestStatus/$id/${statusTypeConverter(status.value)}";
  //   token = UserController.instance.user.value.token;
  //   http.Response? response = await HandleData.getApi(url, token);
  //   var responseData = await ApiProcessorController.errorState(response);
  //   consoleLog(response!.body);
  //   if (responseData == null) {
  //     isLoad.value = false;
  //     update();
  //     return;
  //   }
  //   List<DeliveryModel> data = [];
  //   try {
  //     data = (jsonDecode(responseData) as List)
  //         .map((e) => DeliveryModel.fromJson(e))
  //         .toList();
  //     consoleLog(data.toString());
  //     deliveryList.value = data;
  //   } catch (e) {
  //     consoleLog(e.toString());
  //   }
  //   isLoad.value = false;
  //   update();
  // }
}
