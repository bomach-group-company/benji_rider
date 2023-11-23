// import 'dart:convert';

// import 'package:geolocator/geolocator.dart';

// taskToBeDone(channel, UserController) async {
//   String latitude = '';
//   String longitude = '';
//   try {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     latitude = position.latitude.toString();
//     longitude = position.longitude.toString();
//   } catch (e) {
//     latitude = '';
//     longitude = '';
//     print('in catch');
//   }
//   print('in taskToBeDone again');
//   channel.sink.add(jsonEncode({
//     'rider_id': UserController.instance.user.value.id,
//     'latitude': latitude,
//     'longitude': longitude
//   }));
// }
