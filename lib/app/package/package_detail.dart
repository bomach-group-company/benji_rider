// ignore_for_file: file_names

import 'package:benji_rider/repo/controller/error_controller.dart';
import 'package:benji_rider/repo/controller/package_controller.dart';
import 'package:benji_rider/repo/utils/map_stuff.dart';
import 'package:benji_rider/src/widget/button/my_elevatedbutton.dart';
import 'package:benji_rider/src/widget/maps/map_direction.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class PackageDetails extends StatefulWidget {
  final String taskStatus;
  const PackageDetails({super.key, this.taskStatus = 'processing'});

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  void initState() {
    super.initState();
  }

  toMapDirectionage([String latitudeStr = '', String longitudeStr = '']) {
    double latitude;
    double longitude;
    try {
      latitude = double.parse(latitudeStr);
      longitude = double.parse(longitudeStr);
      if (latitude >= -90 &&
          latitude <= 90 &&
          longitude >= -180 &&
          longitude <= 180) {
      } else {
        ApiProcessorController.errorSnack("Couldn't get the address");
        return;
      }
    } catch (e) {
      ApiProcessorController.errorSnack("Couldn't get the address");
      return;
    }
    Get.to(
      () => MapDirection(latitude: latitude, longitude: longitude),
      routeName: 'MapDirection',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

//============================== ALL VARIABLES ================================\\
  String dispatchMessage = "Your package has been dispatched";

//============================== FUNCTIONS ================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GetBuilder<PackageController>(
        init: PackageController(),
        builder: (controller) {
          return Scaffold(
            appBar: MyAppBar(
              title: "Package Details",
              elevation: 0,
              actions: const [],
              backgroundColor: kPrimaryColor,
            ),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: MyElevatedButton(
                  title: "Delivered",
                  onPressed: () {},
                  isLoading: controller.isLoad.value,
                )),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(kDefaultPadding),
              children: <Widget>[
                Container(
                  width: media.width,
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.30),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 24,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: media.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Package ID',
                              style: TextStyle(
                                color: kTextGreyColor,
                                fontSize: 11.62,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            // Text(
                            //   controller.package.value.created,
                            //   textAlign: TextAlign.right,
                            //   style: const TextStyle(
                            //     color: kTextBlackColor,
                            //     fontSize: 13,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                          ],
                        ),
                        kHalfSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.package.value.id.substring(0, 8),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: kTextBlackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.32,
                              ),
                            ),
                            Text(
                              widget.taskStatus,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: kAccentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.32,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                kSizedBox,
                Container(
                  width: media.width,
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.30),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 24,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Items ordered',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      // ListView.builder(
                      //   itemCount: controller.package.value.orderitems.length,
                      //   shrinkWrap: true,
                      //   itemBuilder: (context, index) {
                      //     var adjustedIndex = index + 1;
                      //     var package =
                      //         controller.package.value.orderitems[index];
                      //     return ListTile(
                      //       titleAlignment: ListTileTitleAlignment.center,
                      //       horizontalTitleGap: 0,
                      //       leading: Text(
                      //         "$adjustedIndex.",
                      //         style: const TextStyle(
                      //           color: kTextBlackColor,
                      //           fontSize: 15,
                      //           fontWeight: FontWeight.normal,
                      //         ),
                      //       ),
                      //       title: Text(
                      //         '${package.product.name} x ${package.quantity.toString()}',
                      //         style: const TextStyle(
                      //           color: kTextBlackColor,
                      //           fontSize: 15,
                      //           fontWeight: FontWeight.normal,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // )
                    ],
                  ),
                ),
                kSizedBox,
                Container(
                  width: media.width,
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 24,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Pickup Detail",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.32,
                            ),
                          ),
                          InkWell(
                            onTap: () => toMapDirectionage(
                                controller.package.value.pickUpAddressLatitude,
                                controller
                                    .package.value.pickUpAddressLongitude),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: kAccentColor,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: kDefaultPadding * 0.2,
                                ),
                                Text(
                                  'Map',
                                  style: TextStyle(
                                      color: kAccentColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      kSizedBox,
                      Row(
                        children: [
                          // Container(
                          //   width: 60,
                          //   height: 60,
                          //   decoration: const BoxDecoration(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(20)),
                          //   ),
                          //   child: CircleAvatar(
                          //     radius:
                          //         deviceType(media.width) >= 2 ? 60 : 30,
                          //     child: ClipOval(
                          //       child: MyImage(
                          //           url: controller
                          //               .package.value.client.image),
                          //     ),
                          //   ),
                          // ),
                          // kWidthSizedBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.package.value.senderName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              kHalfSizedBox,
                              Text(
                                controller.package.value.senderPhoneNumber,
                                style: TextStyle(
                                  color: kTextGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kHalfSizedBox,
                              FutureBuilder(
                                  future: getAddressFromCoordinates(
                                      controller
                                          .package.value.dropOffAddressLatitude,
                                      controller.package.value
                                          .dropOffAddressLongitude),
                                  builder: (context, controller) {
                                    // '6.801965310155346', '7.092915443774477'
                                    return Text(
                                      controller.data ?? 'Loading...',
                                      style: TextStyle(
                                        color: kTextGreyColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  }),
                              kHalfSizedBox,
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                kSizedBox,
                Container(
                  width: media.width,
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  decoration: ShapeDecoration(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 24,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Deliver to Detail",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.32,
                            ),
                          ),
                          InkWell(
                            onTap: () => toMapDirectionage(
                                controller.package.value.pickUpAddressLatitude,
                                controller
                                    .package.value.pickUpAddressLongitude),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: kAccentColor,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: kDefaultPadding * 0.2,
                                ),
                                Text(
                                  'Map',
                                  style: TextStyle(
                                      color: kAccentColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      kSizedBox,
                      Row(
                        children: [
                          // Container(
                          //   width: 60,
                          //   height: 60,
                          //   decoration: const BoxDecoration(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(20)),
                          //   ),
                          //   child: CircleAvatar(
                          //     radius: deviceType(media.width) >= 2 ? 60 : 30,
                          //     child: ClipOval(
                          //       child: MyImage(
                          //           url: controller.package.value.client.image),
                          //     ),
                          //   ),
                          // ),
                          // kWidthSizedBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.package.value.receiverName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              kHalfSizedBox,
                              Text(
                                controller.package.value.receiverPhoneNumber,
                                style: TextStyle(
                                  color: kTextGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kHalfSizedBox,
                              FutureBuilder(
                                  future: getAddressFromCoordinates(
                                      controller
                                          .package.value.dropOffAddressLatitude,
                                      controller.package.value
                                          .dropOffAddressLongitude),
                                  builder: (context, controller) {
                                    return Text(
                                      controller.data ?? 'Loading...',
                                      style: TextStyle(
                                        color: kTextGreyColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  }),
                              kHalfSizedBox,
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                kSizedBox,
              ],
            ),
          );
        });
  }
}
