import 'package:flutter/material.dart';

import '../../src/providers/constants.dart';
import '../../src/reusable_widgets/drawer.dart';
import '../../theme/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isOnline = true;
  bool acceptRequest = false;

  void toggleOnline() {
    setState(() {
      isOnline = !isOnline;
    });
  }

  void acceptRequestFunc() {
    setState(() {
      acceptRequest = !acceptRequest;
    });
  }

  // GoogleMapController? _googleMapController;

  // final LatLng _latLng = const LatLng(
  //   6.456076934514027,
  //   7.507987759047121,
  // );

  // void _onMapCreated(GoogleMapController controller) {
  //   _googleMapController = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreyColor,
      drawer: const MyDrawer(),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            // GoogleMap(
            //   mapType: MapType.normal,
            //   buildingsEnabled: true,
            //   compassEnabled: false,
            //   indoorViewEnabled: true,
            //   mapToolbarEnabled: true,
            //   minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            //   tiltGesturesEnabled: true,
            //   zoomControlsEnabled: false,
            //   zoomGesturesEnabled: true,
            //   myLocationButtonEnabled: true,
            //   myLocationEnabled: true,
            //   cameraTargetBounds: CameraTargetBounds.unbounded,
            //   rotateGesturesEnabled: true,
            //   scrollGesturesEnabled: true,
            //   trafficEnabled: true,
            //   initialCameraPosition: CameraPosition(
            //     target: _latLng,
            //     zoom: 20.0,
            //     tilt: 16,
            //   ),
            //   onMapCreated: _onMapCreated,
            // ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: kTextWhiteColor,
                borderRadius: BorderRadius.all(
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
                            fontFamily: 'Sen',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kSizedBox,
                        const Text(
                          'You are currently offline, go online to start receiving delivery request.',
                          style: TextStyle(
                            color: Color(0xFFD4D4D4),
                            fontSize: 14,
                            fontFamily: 'Sen',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Reject',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Sen',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kTextWhiteColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Accept',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFEC2623),
                                  fontSize: 14,
                                  fontFamily: 'Sen',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    decoration: ShapeDecoration(
                      color: kTextWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isOnline ? 'Online' : 'Offline',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 24,
                                fontFamily: 'Sen',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              splashRadius: 5,
                              onPressed: toggleOnline,
                              icon: Icon(
                                isOnline ? Icons.toggle_on : Icons.toggle_off,
                                color: isOnline
                                    ? kAccentColor
                                    : const Color(0xFF8D8D8D),
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                        kSizedBox,
                        const Text(
                          'You are currently offline, go online to start receiving delivery request.',
                          style: TextStyle(
                            color: Color(0xFF979797),
                            fontSize: 14,
                            fontFamily: 'Sen',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // botto
                ],
              ),
            ),
            // bottom sheet
            ElevatedButton(
              child: const Text('showModalBottomSheet'),
              onPressed: () {
                showModalBottomSheet<void>(
                  barrierColor: kBlackColor.withOpacity(0.7),
                  isScrollControlled: true,
                  enableDrag: true,
                  showDragHandle: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 12,
                                    width: 12,
                                    padding: const EdgeInsets.all(2),
                                    decoration: ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: kAccentColor,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kAccentColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: kAccentColor,
                                    height: kDefaultPadding * 2,
                                    width: 1.5,
                                  ),
                                  Icon(
                                    Icons.location_on_sharp,
                                    size: 12,
                                    color: kAccentColor,
                                  ),
                                ],
                              ),
                              kHalfWidthSizedBox,
                              const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '21 Bartus Street, Abuja Nigeria',
                                    style: TextStyle(
                                      color: Color(0xFF454545),
                                      fontSize: 15.97,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: kDefaultPadding * 2,
                                  ),
                                  Text(
                                    '21 Bartus Street, Abuja Nigeria',
                                    style: TextStyle(
                                      color: Color(0xFF454545),
                                      fontSize: 15.97,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          kSizedBox,
                          kSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 82.13,
                                height: 82.13,
                                decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://via.placeholder.com/82x82"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.13),
                                  ),
                                ),
                              ),
                              kHalfWidthSizedBox,
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rice and Chicken',
                                    style: TextStyle(
                                      color: Color(0xFF454545),
                                      fontSize: 13.69,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  kHalfSizedBox,
                                  Text(
                                    'Food ',
                                    style: TextStyle(
                                      color: Color(0xFF454545),
                                      fontSize: 13.69,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  kHalfSizedBox,
                                  Text(
                                    '3 plates',
                                    style: TextStyle(
                                      color: Color(0xFF454545),
                                      fontSize: 13.69,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  kHalfSizedBox,
                                  Text(
                                    '40kg',
                                    style: TextStyle(
                                      color: Color(0xFF454545),
                                      fontSize: 13.69,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  kHalfSizedBox,
                                  Text(
                                    'Item is fragile (glass) so be careful',
                                    style: TextStyle(
                                      color: Color(0xFF454545),
                                      fontSize: 13.69,
                                      fontFamily: 'Sen',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          kSizedBox,
                          kSizedBox,
                          const Text(
                            'You will be able to contact customer \nonce you accept pick up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 13.69,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          kSizedBox,
                          acceptRequest
                              ? Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kAccentColor,
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          kDefaultPadding * 2,
                                        ),
                                      ),
                                      onPressed: acceptRequestFunc,
                                      child: const Text(
                                        'Accept Request',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.53,
                                          fontFamily: 'Sen',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    kHalfSizedBox,
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          kDefaultPadding * 2,
                                        ),
                                      ),
                                      child: const Text(
                                        'Reject',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFD41920),
                                          fontSize: 15.53,
                                          fontFamily: 'Sen',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kAccentColor,
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          kDefaultPadding * 2,
                                        ),
                                      ),
                                      onPressed: acceptRequestFunc,
                                      child: const Text(
                                        'Accept Request',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.53,
                                          fontFamily: 'Sen',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    kHalfSizedBox,
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          kDefaultPadding * 2,
                                        ),
                                      ),
                                      child: const Text(
                                        'Reject',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFD41920),
                                          fontSize: 15.53,
                                          fontFamily: 'Sen',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          kSizedBox
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
