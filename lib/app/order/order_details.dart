// ignore_for_file: file_names

import 'package:benji_rider/src/repo/utils/helpers.dart';
import 'package:benji_rider/src/widget/button/my_elevatedbutton.dart';
import 'package:benji_rider/src/widget/image/my_image.dart';
import 'package:benji_rider/src/widget/maps/map_direction.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/error_controller.dart';
import '../../src/repo/controller/order_status_change.dart';
import '../../src/repo/utils/map_stuff.dart';
import '../../theme/colors.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
  String dispatchMessage = "Your order has been dispatched";

//============================== FUNCTIONS ================================\\

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GetBuilder<OrderStatusChangeController>(
        init: OrderStatusChangeController(),
        builder: (controller) {
          return Scaffold(
            appBar: MyAppBar(
              title: "Order Details",
              elevation: 0,
              actions: const [],
              backgroundColor: kPrimaryColor,
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: controller.order.value.deliveryStatus == 'CANC'
                  ? MyElevatedButton(
                      disable: true,
                      title: "Cancelled",
                      onPressed: null,
                      isLoading: controller.isLoad.value,
                    )
                  : controller.order.value.deliveryStatus == "PEND"
                      ? MyElevatedButton(
                          title: "Dispatched",
                          onPressed: controller.orderDispatched,
                          isLoading: controller.isLoad.value,
                        )
                      : controller.order.value.deliveryStatus == 'received' ||
                              controller.order.value.deliveryStatus ==
                                  'dispatched'
                          ? MyElevatedButton(
                              title: "Delivered",
                              onPressed: controller.orderDelivered,
                              isLoading: controller.isLoad.value,
                            )
                          : controller.order.value.deliveryStatus == 'COMP'
                              ? MyElevatedButton(
                                  disable: true,
                                  title: "Cashout",
                                  onPressed: controller.orderPayment,
                                  isLoading: controller.isLoad.value,
                                )
                              : MyElevatedButton(
                                  disable: true,
                                  title: "Completed",
                                  onPressed: null,
                                  isLoading: controller.isLoad.value,
                                ),
            ),
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
                              'Order ID',
                              style: TextStyle(
                                color: kTextGreyColor,
                                fontSize: 11.62,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              controller.order.value.created,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: kTextBlackColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        kHalfSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.order.value.code,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: kTextBlackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.32,
                              ),
                            ),
                            Text(
                              statusConst[controller.order.value.deliveryStatus
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Items ordered',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      ListView.builder(
                        itemCount: controller.order.value.orderitems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var adjustedIndex = index + 1;
                          var order = controller.order.value.orderitems[index];
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            horizontalTitleGap: 0,
                            leading: Text(
                              "$adjustedIndex.",
                              style: const TextStyle(
                                color: kTextBlackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            title: Text(
                              '${order.product.name} x ${order.quantity.toString()}',
                              style: const TextStyle(
                                color: kTextBlackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                kSizedBox,
                controller.order.value.orderitems.isEmpty
                    ? const SizedBox()
                    : Container(
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
                                      controller.order.value.orderitems.first
                                          .product.vendorId.latitude,
                                      controller.order.value.orderitems.first
                                          .product.vendorId.longitude),
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.locationDot,
                                        color: kAccentColor,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Map',
                                        style: TextStyle(
                                          color: kAccentColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            kSizedBox,
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: MyImage(
                                    url: controller.order.value.client.image,
                                  ),
                                ),
                                kWidthSizedBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${controller.order.value.orderitems.first.product.vendorId.firstName} ${controller.order.value.orderitems.first.product.vendorId.lastName}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: kTextBlackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    kHalfSizedBox,
                                    Text(
                                      controller.order.value.orderitems.first
                                          .product.vendorId.phone,
                                      style: TextStyle(
                                        color: kTextGreyColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    kHalfSizedBox,
                                    SizedBox(
                                      width: media.width - 160,
                                      child: FutureBuilder(
                                          future: getAddressFromCoordinates(
                                              controller
                                                  .order
                                                  .value
                                                  .orderitems
                                                  .first
                                                  .product
                                                  .vendorId
                                                  .latitude,
                                              controller
                                                  .order
                                                  .value
                                                  .orderitems
                                                  .first
                                                  .product
                                                  .vendorId
                                                  .longitude),
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
                                controller.order.value.deliveryAddress.latitude,
                                controller
                                    .order.value.deliveryAddress.longitude),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  color: kAccentColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Map',
                                  style: TextStyle(
                                    color: kAccentColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      kSizedBox,
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: MyImage(
                              url: controller.order.value.client.image,
                            ),
                          ),
                          kWidthSizedBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.order.value.client.firstName} ${controller.order.value.client.lastName}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              kHalfSizedBox,
                              Text(
                                controller.order.value.client.phone,
                                style: TextStyle(
                                  color: kTextGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kHalfSizedBox,
                              SizedBox(
                                width: media.width - 160,
                                child: FutureBuilder(
                                    future: getAddressFromCoordinates(
                                        controller.order.value.deliveryAddress
                                            .latitude,
                                        controller.order.value.deliveryAddress
                                            .longitude),
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
              ],
            ),
          );
        });
  }
}
