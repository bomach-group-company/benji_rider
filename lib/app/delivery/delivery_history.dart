import 'package:benji_rider/repo/controller/delivery_history_controller.dart';
import 'package:benji_rider/src/widget/card/empty.dart';
import 'package:benji_rider/src/widget/image/my_image.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/responsive/reponsive_width.dart';
import '../../theme/colors.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  bool isLoading = false;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "Delivery",
        elevation: 0.0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                  child: GetBuilder<DeliveryHistoryController>(
                      initState: (state) => DeliveryHistoryController.instance
                          .getDeliveryHistory(),
                      builder: (controller) {
                        if (controller.isLoad.value &&
                            controller.deliveryList.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: kAccentColor,
                            ),
                          );
                        }
                        if (controller.deliveryList.isEmpty) {
                          return const EmptyCard();
                        }
                        return ListView.separated(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.deliveryList.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(kDefaultPadding),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: kDefaultPadding / 2),
                          itemBuilder: (BuildContext context, int index) {
                            return MyResponsiveWidth(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            child: MyImage(
                                              url: controller
                                                  .deliveryList[index]
                                                  .order
                                                  .client
                                                  .image,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'ID ${controller.deliveryList[index].order.code}',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF979797),
                                                        fontSize: 12,
                                                        fontFamily: 'Sen',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Container(
                                                      // width: 68,
                                                      // height: 24,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 7,
                                                          vertical: 5),
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side:
                                                              const BorderSide(
                                                            width: 0.50,
                                                            color: Color(
                                                                0xFFC8C8C8),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        controller
                                                            .deliveryList[index]
                                                            .deliveryStatus,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: kAccentColor,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              'Overpass',
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 12,
                                                          width: 12,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          decoration:
                                                              ShapeDecoration(
                                                            shape: OvalBorder(
                                                              side: BorderSide(
                                                                width: 1,
                                                                color:
                                                                    kAccentColor,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  kAccentColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          color: kAccentColor,
                                                          height: 10,
                                                          width: 1.5,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .location_on_sharp,
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            controller
                                                                .deliveryList[
                                                                    index]
                                                                .order
                                                                .deliveryAddress
                                                                .details,
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
                                                          ),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        controller
                                                            .deliveryList[index]
                                                            .deliveredDate,
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF929292),
                                                          fontSize: 10,
                                                          fontFamily:
                                                              'Overpass',
                                                          height: 1.5,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
