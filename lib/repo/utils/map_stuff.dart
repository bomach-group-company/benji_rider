import 'package:geocoding/geocoding.dart';

Future<String> getAddressFromCoordinates(
    String latitude, String longitude) async {
  try {
    print('$latitude, $longitude');
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude));
    print(placemarks);
    if (placemarks.isNotEmpty) {
      Placemark firstPlacemark = placemarks.first;
      String address =
          '${firstPlacemark.street}, ${firstPlacemark.locality}, ${firstPlacemark.administrativeArea}, ${firstPlacemark.country}';
      return address;
    } else {
      return 'No address found';
    }
  } catch (e) {
    print('error in placemarks $e');
    return 'Error getting address';
  }
}
