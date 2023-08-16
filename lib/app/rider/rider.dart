// ignore_for_file: unused_field, prefer_typing_uninitialized_variables

import 'package:benji_rider/src/widget/section/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/card/online_offline_card.dart';
import '../../src/widget/card/pickup_and_delivery_card.dart';
import '../../theme/colors.dart';
import '../../theme/model.dart';
import '../delivery/deliveries_completed.dart';

class RiderPage extends StatefulWidget {
  const RiderPage({super.key});

  @override
  State<RiderPage> createState() => _RiderPageState();
}

class _RiderPageState extends State<RiderPage> {
  //=================================== ALL VARIABLES ======================================================\\

  //=================================== BOOL VALUES ======================================================\\
  bool isLoading = false;

  bool acceptRequest = false;
  bool showDeliveryDialog = false;
  bool pickedUp = false;

  //=================================== CONTROLLERS ======================================================\\
  GoogleMapController? _googleMapController;

  //=================================== FUNCTIONS ======================================================\\
  void deliveryFunc(context) {
    setState(() {
      pickedUp = false;
      acceptRequest = !acceptRequest;
      showDeliveryDialog = !showDeliveryDialog;
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
      pickedUp = true;
      Navigator.of(context).pop();
    });
  }

  void acceptRequestFunc(context) {
    setState(() {
      acceptRequest = !acceptRequest;
      showDeliveryDialog = !showDeliveryDialog;
      Navigator.of(context).pop();
    });
  }

  Future<bool> _getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnline = await prefs.getBool('isOnline');
    return isOnline ?? false;
  }

  //=========================== toggleOnline FUNCTION ====================================\\
  Future<void> toggleOnline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isOnline = prefs.getBool('isOnline') ?? false;
    await prefs.setBool('isOnline', !isOnline);

    setState(() {
      isLoading = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showDeliveryDialog = true;
      });
    });
  }

  final LatLng _latLng = const LatLng(
    6.456076934514027,
    7.507987759047121,
  );

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

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
                        buildingsEnabled: true,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                        tiltGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        cameraTargetBounds: CameraTargetBounds.unbounded,
                        rotateGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        trafficEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: _latLng,
                          zoom: 20.0,
                          tilt: 16,
                        ),
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
                }),
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
            Container(
              margin: const EdgeInsets.only(
                top: 90,
                bottom: 30,
                left: 30,
                right: 30,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // red delivery request card
                    child: showDeliveryDialog
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            decoration: ShapeDecoration(
                              color: kAccentColor.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Delivery Request',
                                  style: TextStyle(
                                    color: kTextWhiteColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                kSizedBox,
                                const Text(
                                  '21 Bartus Street, Enugu. 12km 20mins.',
                                  style: TextStyle(
                                    color: Color(0xFFD4D4D4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kTextWhiteColor,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        deliveryModel(context, () {
                                          acceptRequestFunc(context);
                                        });
                                      },
                                      child: Text(
                                        'Go',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: kAccentColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ),
                  const Spacer(),
                  acceptRequest
                      ? PickupDeliveryCard(
                          isDelivery: pickedUp,
                          pickupFunc: () {
                            deliveryModel(
                              context,
                              () {
                                acceptRequestFunc(context);
                              },
                              isPickup: true,
                              pickedUpFunc: () {
                                pickedUpFunc(context);
                              },
                            );
                          },
                          deliveryFunc: () {
                            deliveryModel(
                              context,
                              () {
                                acceptRequestFunc(context);
                              },
                              isDelivery: true,
                              deliveryFunc: () {
                                deliveryFunc(context);
                              },
                            );
                          },
                        )
                      : FutureBuilder(
                          future: _getStatus(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return OnlineOfflineCard(
                                isOnline: snapshot.data,
                                toggleOnline: toggleOnline,
                              );
                            } else {
                              return Center(
                                child: SpinKitChasingDots(
                                  color: kAccentColor,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
