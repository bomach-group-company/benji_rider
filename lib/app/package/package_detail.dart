// ignore_for_file: file_names

import 'package:benji_rider/src/repo/utils/helpers.dart';
import 'package:benji_rider/src/widget/button/my_elevatedbutton.dart';
import 'package:benji_rider/src/widget/form_and_auth/my%20textformfield.dart';
import 'package:benji_rider/src/widget/maps/map_direction.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/error_controller.dart';
import '../../src/repo/controller/package_controller.dart';
import '../../src/repo/utils/map_stuff.dart';
import '../../theme/colors.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({super.key});

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
  final codeEC = TextEditingController();

//================= Focus Nodes ==================\\
  final codeFN = FocusNode();
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
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: ListView(
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
                                statusPackageConst[controller
                                        .package.value.status
                                        .toLowerCase()] ??
                                    'NOT SPECIFIED',
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
                                  controller
                                      .package.value.pickUpAddressLatitude,
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
                                SizedBox(
                                  width: media.width - 60,
                                  child: FutureBuilder(
                                      future: getAddressFromCoordinates(
                                          controller.package.value
                                              .dropOffAddressLatitude,
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
                                ),
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
                                  controller
                                      .package.value.pickUpAddressLatitude,
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
                                SizedBox(
                                  width: media.width - 60,
                                  child: FutureBuilder(
                                      future: getAddressFromCoordinates(
                                          controller.package.value
                                              .dropOffAddressLatitude,
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
                                ),
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
                    child: controller.package.value.status == 'CANC'
                        ? const MyElevatedButton(
                            disable: true,
                            title: "Cancelled",
                            onPressed: null,
                            isLoading: false,
                          )
                        : controller.package.value.status == 'pending'
                            ? MyElevatedButton(
                                title: "Collected",
                                onPressed: controller.orderDispatched,
                                isLoading: controller.isLoad.value,
                              )
                            : controller.package.value.status == 'received' ||
                                    controller.package.value.status ==
                                        'dispatched'
                                ? SizedBox(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Enter package delivery code and confirm',
                                          style: TextStyle(color: kAccentColor),
                                        ),
                                        kSizedBox,
                                        MyTextFormField(
                                          controller: codeEC,
                                          focusNode: codeFN,
                                          hintText:
                                              "Enter the code from the user",
                                          textInputAction: TextInputAction.done,
                                          textInputType: TextInputType.name,
                                          validator: (value) {
                                            if (value == null ||
                                                value!.isEmpty) {
                                              codeFN.requestFocus();
                                              return "Enter the code from the user";
                                            }
                                            return null;
                                          },
                                        ),
                                        kSizedBox,
                                        MyElevatedButton(
                                          title: "Delivered",
                                          onPressed: () => controller
                                              .orderDelivered(codeEC.text),
                                          isLoading: controller.isLoad.value,
                                        )
                                      ],
                                    ),
                                  )
                                : controller.package.value.status == 'completed'
                                    ? MyElevatedButton(
                                        disable: true,
                                        title: "Cashout",
                                        onPressed: controller.packagePayment,
                                        isLoading: controller.isLoad.value,
                                      )
                                    : MyElevatedButton(
                                        disable: true,
                                        title: "Completed",
                                        onPressed: () {},
                                        isLoading: false,
                                      ),
                  ),
                  kSizedBox,
                ],
              ),
            ),
          );
        });
  }
}
