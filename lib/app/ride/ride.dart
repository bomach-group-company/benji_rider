// // ignore_for_file: unused_field, prefer_typing_uninitialized_variables

// import 'dart:async';

// import 'package:benji_rider/src/widget/section/drawer.dart';
// import 'package:benji_rider/src/widget/section/my_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../theme/colors.dart';

// class Ride extends StatefulWidget {
//   const Ride({super.key});

//   @override
//   State<Ride> createState() => _RideState();
// }

// class _RideState extends State<Ride> {
//   //=================================== INITIAL STATE ======================================================\\

//   deliveryModel() {}
//   //=================================== ALL VARIABLES ======================================================\\
//   Position? _currentPosition;
//   final _geoLocator = Geolocator();

//   //=================================== BOOL VALUES ======================================================\\
//   final bool _isLoading = false;

//   final bool _acceptRequest = false;
//   final bool _showDeliveryDialog = false;
//   final bool _pickedUp = false;

//   //=================================== CONTROLLERS ======================================================\\
//   final Completer<GoogleMapController> _googleMapController = Completer();
//   GoogleMapController? _newGoogleMapController;

//   //=================================== FUNCTIONS ======================================================\\

//   //=========================== Google Maps ====================================\\

//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.',
//       );
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     // _currentPosition = _position;

//     LatLng latLngPosition = LatLng(position.latitude, position.longitude);
//     CameraPosition cameraPosition =
//         CameraPosition(target: latLngPosition, zoom: 14);
//     _newGoogleMapController!
//         .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return position;
//   }

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(
//       6.455898890177413,
//       7.507847720077416,
//     ),
//     zoom: 14.4746,
//   );

//   void _onMapCreated(GoogleMapController controller) {
//     _googleMapController.isCompleted;
//     _newGoogleMapController = controller;
//     _determinePosition();
//   }

// //===================================================================================================================\\

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       onDrawerChanged: (isOpened) {
//         if (isOpened == false) {
//           setState(() {});
//         }
//       },
//       drawer: const MyDrawer(),
//       appBar: MyAppBar(
//         title: "Tasks",
//         elevation: 10.0,
//         actions: const [],
//         backgroundColor: kPrimaryColor,
//         toolbarHeight: kToolbarHeight,
//       ),
//       body: SafeArea(
//         maintainBottomViewPadding: true,
//         child: ListView(
//           physics: const BouncingScrollPhysics(),
//           shrinkWrap: true,
//           children: const [
//             // FutureBuilder(
//             //   future: _getStatus(),
//             //   builder: (context, snapshot) {
//             //     if (snapshot.hasData) {
//             //       if (snapshot.data == false) {
//             //         return const Center();
//             //       } else {
//             //         return GoogleMap(
//             //           mapType: MapType.normal,
//             //           padding: const EdgeInsets.only(bottom: 125),
//             //           buildingsEnabled: true,
//             //           compassEnabled: true,
//             //           indoorViewEnabled: true,
//             //           mapToolbarEnabled: true,
//             //           minMaxZoomPreference: MinMaxZoomPreference.unbounded,
//             //           tiltGesturesEnabled: true,
//             //           zoomControlsEnabled: true,
//             //           zoomGesturesEnabled: true,
//             //           myLocationButtonEnabled: true,
//             //           myLocationEnabled: true,
//             //           cameraTargetBounds: CameraTargetBounds.unbounded,
//             //           rotateGesturesEnabled: true,
//             //           scrollGesturesEnabled: true,
//             //           trafficEnabled: true,
//             //           initialCameraPosition: _kGooglePlex,
//             //           onMapCreated: _onMapCreated,
//             //         );
//             //       }
//             //     } else {
//             //       return Center(
//             //         child: CircularProgressIndicator(
//             //           color: kAccentColor,
//             //         ),
//             //       );
//             //     }
//             //   },
//             // ),

//             // Container(
//             //   margin: const EdgeInsets.all(30),
//             //   decoration: BoxDecoration(
//             //     color: kPrimaryColor,
//             //     borderRadius: const BorderRadius.all(
//             //       Radius.circular(20),
//             //     ),
//             //   ),
//             //   child: Builder(
//             //     builder: (context) => IconButton(
//             //       splashRadius: 20,
//             //       onPressed: () {
//             //         Scaffold.of(context).openDrawer();
//             //       },
//             //       icon: Icon(
//             //         Icons.menu,
//             //         color: kAccentColor,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
