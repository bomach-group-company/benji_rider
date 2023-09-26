// ignore_for_file: unused_field, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:benji_rider/src/widget/section/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/widget/card/online_offline_card.dart';
import '../../theme/colors.dart';
import '../delivery/deliveries_completed.dart';

class Ride extends StatefulWidget {
  const Ride({super.key});

  @override
  State<Ride> createState() => _RideState();
}

class _RideState extends State<Ride> {
  //=================================== INITIAL STATE ======================================================\\

  @override
  void initState() {
    super.initState();
  }

  //=================================== ALL VARIABLES ======================================================\\
  Position? _currentPosition;
  var _geoLocator = Geolocator();

  //=================================== BOOL VALUES ======================================================\\
  bool _isLoading = false;

  bool _acceptRequest = false;
  bool _showDeliveryDialog = false;
  bool _pickedUp = false;

  //=================================== CONTROLLERS ======================================================\\
  Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? _newGoogleMapController;

  //=================================== FUNCTIONS ======================================================\\
  void deliveryFunc(context) {
    setState(() {
      _pickedUp = false;
      _acceptRequest = !_acceptRequest;
      _showDeliveryDialog = !_showDeliveryDialog;

      Get.to(
        const DeliverComplete(),
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
    });
  }

  void pickedUpFunc(context) {
    setState(() {
      _pickedUp = true;

      Navigator.of(context).pop();
    });
  }

  void acceptRequestFunc(context) {
    setState(() {
      _acceptRequest = !_acceptRequest;
      _showDeliveryDialog = !_showDeliveryDialog;
      Navigator.of(context).pop();
    });
  }

  Future<bool> _getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnline = await prefs.getBool('isOnline');
    return isOnline ?? false;
  }

  //=========================== _toggleOnline FUNCTION ====================================\\

  Future<void> _toggleOnline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isOnline = prefs.getBool('isOnline') ?? false;
    await prefs.setBool('isOnline', !isOnline);

    setState(() {
      _isLoading = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showDeliveryDialog = true;
      });
    });
  }

  //=========================== Google Maps ====================================\\

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    Position _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // _currentPosition = _position;

    LatLng _latLngPosition = LatLng(_position.latitude, _position.longitude);
    CameraPosition _cameraPosition =
        new CameraPosition(target: _latLngPosition, zoom: 14);
    _newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await _position;
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      6.455898890177413,
      7.507847720077416,
    ),
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController.isCompleted;
    _newGoogleMapController = controller;
    _determinePosition();
  }

//===================================================================================================================\\

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpened) {
        if (isOpened == false) {
          setState(() {});
        }
      },
      drawer: MyDrawer(),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            FutureBuilder(
              future: _getStatus(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == false) {
                    return Center();
                  } else {
                    return GoogleMap(
                      mapType: MapType.normal,
                      padding: EdgeInsets.only(bottom: 125),
                      buildingsEnabled: true,
                      compassEnabled: true,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      tiltGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      cameraTargetBounds: CameraTargetBounds.unbounded,
                      rotateGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      trafficEnabled: true,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: _onMapCreated,
                    );
                  }
                } else {
                  return Center(
                    child: SpinKitChasingDots(
                      color: kAccentColor,
                    ),
                  );
                }
              },
            ),

            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Builder(
                builder: (context) => IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: kAccentColor,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 90,
              left: 30,
              right: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                //Red delivery request card
                child:

                    // _showDeliveryDialog
                    //     ? Container(
                    //         width: double.infinity,
                    //         padding: const EdgeInsets.only(
                    //           top: 10,
                    //           left: 20,
                    //           right: 20,
                    //           bottom: 20,
                    //         ),
                    //         decoration: ShapeDecoration(
                    //           color: kAccentColor.withOpacity(0.6),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             const Text(
                    //               'Delivery Request',
                    //               style: TextStyle(
                    //                 color: kTextWhiteColor,
                    //                 fontSize: 24,
                    //                 fontWeight: FontWeight.w700,
                    //               ),
                    //             ),
                    //             kSizedBox,
                    //             const Text(
                    //               '21 Bartus Street, Enugu. 12km 20mins.',
                    //               style: TextStyle(
                    //                 color: Color(0xFFD4D4D4),
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w400,
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               height: 10,
                    //             ),
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.end,
                    //               children: [
                    //                 ElevatedButton(
                    //                   style: ElevatedButton.styleFrom(
                    //                     backgroundColor: kTextWhiteColor,
                    //                     shape: const RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.all(
                    //                         Radius.circular(20),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   onPressed: () {
                    //                     deliveryModel(context, () {
                    //                       acceptRequestFunc(context);
                    //                     });
                    //                   },
                    //                   child: Text(
                    //                     'Go',
                    //                     textAlign: TextAlign.center,
                    //                     style: TextStyle(
                    //                       color: kAccentColor,
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.w400,
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       )
                    // :
                    const SizedBox(),
              ),
            ),
            // _acceptRequest
            //     ? PickupDeliveryCard(
            //         isDelivery: _pickedUp,
            //         pickupFunc: () {
            //           deliveryModel(
            //             context,
            //             () {
            //               acceptRequestFunc(context);
            //             },
            //             isPickup: true,
            //             pickedUpFunc: () {
            //               pickedUpFunc(context);
            //             },
            //           );
            //         },
            //         deliveryFunc: () {
            //           deliveryModel(
            //             context,
            //             () {
            //               acceptRequestFunc(context);
            //             },
            //             isDelivery: true,
            //             deliveryFunc: () {
            //               deliveryFunc(context);
            //             },
            //           );
            //         },
            //       )
            //     :
            FutureBuilder(
              future: _getStatus(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    bottom: 10,
                    right: snapshot.data ? 10 : 0,
                    left: snapshot.data ? 10 : 0,
                    child: OnlineOfflineCard(
                      isOnline: snapshot.data,
                      toggleOnline: _toggleOnline,
                    ),
                  );
                } else {
                  return Center(
                    child: SpinKitChasingDots(
                      color: kAccentColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
