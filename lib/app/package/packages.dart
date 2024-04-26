import 'package:benji_rider/app/package/package_detail.dart';
import 'package:benji_rider/src/repo/utils/helpers.dart';
import 'package:benji_rider/src/widget/card/empty.dart';
import 'package:benji_rider/src/widget/image/my_image.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/order_controller.dart';
import '../../src/repo/controller/package_controller.dart';
import '../../src/repo/models/delivery_model.dart';
import '../../src/repo/utils/map_stuff.dart';
import '../../theme/colors.dart';

class Package extends StatefulWidget {
  const Package({super.key});

  @override
  State<Package> createState() => _PackageState();
}

class _PackageState extends State<Package> {
  bool isLoading = false;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _toDetailPage(DeliveryModel deliveryObj, String taskStatus) async {
    await PackageController.instance.setPackage(deliveryObj);
    Get.to(
      () => const PackageDetails(),
      routeName: 'PackageDetails',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "My Packages",
        elevation: 0.0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            GetBuilder<PackageController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              controller.status.value == StatusType.processing
                                  ? kAccentColor
                                  : kDefaultCategoryBackgroundColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                        ),
                        onPressed: controller.isLoad.value &&
                                controller.status.value != StatusType.processing
                            ? null
                            : () async {
                                await controller
                                    .setStatus(StatusType.processing);
                              },
                        child: Text(
                          'Accepted',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                controller.status.value == StatusType.processing
                                    ? kTextWhiteColor
                                    : kGreyColor2,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor:
                      //         controller.status.value == StatusType.delivered
                      //             ? kAccentColor
                      //             : kDefaultCategoryBackgroundColor,
                      //     shape: const RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(16))),
                      //   ),
                      //   onPressed: controller.isLoad.value &&
                      //           controller.status.value != StatusType.delivered
                      //       ? null
                      //       : () async {
                      //           await controller
                      //               .setStatus(StatusType.delivered);
                      //         },
                      //   child: Text(
                      //     'Completed',
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //       color:
                      //           controller.status.value == StatusType.delivered
                      //               ? kTextWhiteColor
                      //               : kGreyColor2,
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   width: 15,
                      // ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              controller.status.value == StatusType.cancelled
                                  ? kAccentColor
                                  : kDefaultCategoryBackgroundColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        ),
                        onPressed: controller.isLoad.value &&
                                controller.status.value != StatusType.cancelled
                            ? null
                            : () async {
                                await controller
                                    .setStatus(StatusType.cancelled);
                              },
                        child: Text(
                          'Rejected',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                controller.status.value == StatusType.cancelled
                                    ? kTextWhiteColor
                                    : kGreyColor2,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            GetBuilder<PackageController>(
                initState: (state) =>
                    PackageController.instance.getOrdersByStatus(),
                builder: (controller) {
                  if (controller.isLoad.value &&
                      controller.vendorsOrderList.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          kSizedBox,
                          CircularProgressIndicator(
                            color: kAccentColor,
                          ),
                        ],
                      ),
                    );
                  }
                  if (controller.vendorsOrderList.isEmpty) {
                    return const EmptyCard();
                  }
                  return ListView.separated(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.vendorsOrderList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(kDefaultPadding),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: kDefaultPadding / 2),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => _toDetailPage(
                            controller.vendorsOrderList[index],
                            controller.vendorsOrderList[index].deliveryStatus),
                        child: Column(
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                color: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      // width: 110,
                                      height: 119,
                                      decoration: const ShapeDecoration(
                                        color: kGreyColor1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: MyImage(
                                        url: controller.vendorsOrderList[index]
                                            .order.client.image,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7,
                                        horizontal: 12,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Task ID ${controller.vendorsOrderList[index].id.substring(0, 8)}...',
                                                style: const TextStyle(
                                                  color: Color(0xFF979797),
                                                  fontSize: 12,
                                                  fontFamily: 'Sen',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Container(
                                                // width: 68,
                                                // height: 24,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7,
                                                        vertical: 5),
                                                decoration: ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFFC8C8C8),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                child: Text(
                                                  statusPackageConst[controller
                                                          .vendorsOrderList[
                                                              index]
                                                          .package
                                                          .status
                                                          .toLowerCase()] ??
                                                      'NOT SPECIFIED',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: kAccentColor,
                                                    fontSize: 10,
                                                    fontFamily: 'Overpass',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 12,
                                                    width: 12,
                                                    padding:
                                                        const EdgeInsets.all(2),
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
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    color: kAccentColor,
                                                    height: 10,
                                                    width: 1.5,
                                                  ),
                                                  Icon(
                                                    Icons.location_on_sharp,
                                                    size: 12,
                                                    color: kAccentColor,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FutureBuilder(
                                                        future: getAddressFromCoordinates(
                                                            controller
                                                                .vendorsOrderList[
                                                                    index]
                                                                .package
                                                                .dropOffAddressLatitude,
                                                            controller
                                                                .vendorsOrderList[
                                                                    index]
                                                                .package
                                                                .dropOffAddressLongitude),
                                                        builder: (context,
                                                            controller) {
                                                          return Text(
                                                            controller.data ??
                                                                'Loading',
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF979797),
                                                              fontSize: 10,
                                                              height: 2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          );
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 22,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  controller
                                                              .vendorsOrderList[
                                                                  index]
                                                              .deliveredDate ==
                                                          ''
                                                      ? 'N/A'
                                                      : formatDateAndTime(DateTime
                                                          .parse(controller
                                                              .vendorsOrderList[
                                                                  index]
                                                              .deliveredDate)),
                                                  style: const TextStyle(
                                                    color: Color(0xFF929292),
                                                    fontSize: 10,
                                                    fontFamily: 'Overpass',
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
