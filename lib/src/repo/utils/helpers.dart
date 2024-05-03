import 'dart:convert';

import 'package:benji_rider/main.dart';
import 'package:benji_rider/src/repo/controller/error_controller.dart';
import 'package:benji_rider/theme/colors.dart';
import 'package:http/http.dart' as http;

import '../controller/api_url.dart';
import '../controller/order_controller.dart';
import '../models/user_model.dart';

final Map statusConst = {
  'pend': 'PENDING',
  'comp': 'COMPLETED',
  'canc': 'CANCELLED',
  'dispatched': 'DISPATCHED',
  'received': 'RECEIVED',
  'delivered': 'DELIVERED',
  'confirmed': 'CONFIRMED',
};

final Map statusPackageConst = {
  'pending': 'PENDING',
  'completed': 'COMPLETED',
  'canc': 'CANCELLED',
  'dispatched': 'DISPATCHED',
  'received': 'RECEIVED',
  'confirmed': 'CONFIRMED',
};

Future<void> saveUser(String user, String token) async {
  Map data = jsonDecode(user);
  data['token'] = token;
  await prefs.setString('user', jsonEncode(data));
}

User getUserSync() {
  String? user = prefs.getString('user');
  if (user == null) {
    return User.fromJson(null);
  }
  return modelUser(user);
}

Future<User?> getUser() async {
  String? user = prefs.getString('user');
  if (user == null) {
    return null;
  }
  return modelUser(user);
}

Future<bool> deleteUser() async {
  prefs.remove('isOnline');
  prefs.remove('isVisibleCash');
  prefs.remove('rememberMe');
  return prefs.remove('user');
}

// Future<Map<String, String>> authHeader([String? authToken]) async {
//   if (authToken == null) {
//     User? user = await getUser();
//     if (user != null) {
//       authToken = user.token;
//     }
//   }
//   return {
//     'Authorization': 'Bearer $authToken',
//     'Content-Type': 'application/json'
//   };
// }

dynamic isUnauthorized(Map data) {
  if (data.containsKey('detail') && data['detail'] == 'Unauthorized') {
    // return Get.offAll(
    //   () => const Login(),
    //   routeName: 'Login',
    //   predicate: (route) => false,
    //   duration: const Duration(milliseconds: 300),
    //   fullscreenDialog: true,
    //   curve: Curves.easeIn,
    //   popGesture: false,
    //   transition: Transition.rightToLeft,
    // );
  } else {
    return data;
  }
}

checkUserAuth() async {
  User? haveUser = await getUser();
  if (haveUser == null) {
    // return Get.offAll(
    //   () => const Login(),
    //   routeName: 'Login',
    //   predicate: (route) => false,
    //   duration: const Duration(milliseconds: 300),
    //   fullscreenDialog: true,
    //   curve: Curves.easeIn,
    //   popGesture: false,
    //   transition: Transition.rightToLeft,
    // );
  }
}

checkAuth(context) async {
  User? haveUser = await getUser();
  bool? isAuth = await isAuthorized();
  if (haveUser == null || isAuth == false) {
    ApiProcessorController.errorSnack("Please login to continue");

    // return Get.offAll(
    //   () => const Login(),
    //   routeName: 'Login',
    //   predicate: (route) => false,
    //   duration: const Duration(milliseconds: 300),
    //   fullscreenDialog: true,
    //   curve: Curves.easeIn,
    //   popGesture: false,
    //   transition: Transition.rightToLeft,
    // );
  }
}

Map<String, String> authHeader([String? authToken, String? contentType]) {
  if (authToken == null) {
    User? user = getUserSync();
    authToken = user.token;
  }

  Map<String, String> res = {
    'Authorization': 'Bearer $authToken',
  };
  // 'Content-Type': 'application/json', 'application/x-www-form-urlencoded'

  if (contentType != null) {
    res['Content-Type'] = contentType;
  }
  return res;
}

Future<bool> isAuthorized() async {
  try {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/auth/'),
      headers: authHeader(),
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      if (data["detail"] == "Unauthorized") {
        return false;
      }
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}

String statusTypeConverter(StatusType statusType) {
  if (statusType == StatusType.delivered) {
    return "completed";
  }
  if (statusType == StatusType.processing) {
    return "processing";
  }
  if (statusType == StatusType.cancelled) {
    return "cancelled";
  }
  return "processing";
}
