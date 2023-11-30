// ignore_for_file: file_names

import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/form_controller.dart';
import 'package:benji_rider/repo/controller/order_controller.dart';
import 'package:benji_rider/repo/models/order_model.dart';
import 'package:benji_rider/repo/utils/map_stuff.dart';
import 'package:benji_rider/src/providers/responsive_constant.dart';
import 'package:benji_rider/src/widget/button/my_elevatedbutton.dart';
import 'package:benji_rider/src/widget/image/my_image.dart';
import 'package:benji_rider/src/widget/maps/map_direction.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class OrderDetails extends StatefulWidget {
  final Order order;
  final String orderStatus;
  final Color orderStatusColor;

  const OrderDetails(
      {super.key,
      required this.order,
      required this.orderStatus,
      required this.orderStatusColor});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    super.initState();
  }

  toMapDirectionage(
      [double latitude = 6.463832607452451,
      double longitude = 7.53990682395574]) {
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
  bool isDispatched = false;
  String dispatchMessage = "Your order has been dispatched";

//============================== FUNCTIONS ================================\\
  orderDispatched() async {
    Map<String, dynamic> data = {
      "delivery_status": "dispatched",
    };

    var url =
        "${Api.baseUrl}${Api.changeOrderStatus}?order_id=${widget.order.id}&display_message=$dispatchMessage";
    await FormController.instance.patchAuth(url, data, 'dispatchOrder');
    if (FormController.instance.status.toString().startsWith('2')) {
      setState(() {
        isDispatched = true;
      });
      await Future.delayed(const Duration(microseconds: 500), () {
        OrderController.instance.resetOrders();
        Get.close(1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        title: "Order Details",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: isDispatched == false && widget.orderStatus == "Pending"
            ? GetBuilder<FormController>(
                init: FormController(),
                builder: (controller) {
                  return MyElevatedButton(
                    title: "Dispatched",
                    onPressed: orderDispatched,
                    isLoading: controller.isLoad.value,
                  );
                },
              )
            : const SizedBox(),
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
                        widget.order.created,
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
                        widget.order.code,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: kTextBlackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      Text(
                        widget.orderStatus,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: widget.orderStatusColor,
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
                  itemCount: widget.order.orderitems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var adjustedIndex = index + 1;
                    var order = widget.order.orderitems[index];
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
          widget.order.orderitems.isEmpty
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
                            "Pickup's Detail",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextBlackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.32,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 25),
                            child: InkWell(
                              onTap: toMapDirectionage,
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
                            child: CircleAvatar(
                              radius: deviceType(media.width) >= 2 ? 60 : 30,
                              child: ClipOval(
                                child: MyImage(url: widget.order.client.image),
                              ),
                            ),
                          ),
                          kWidthSizedBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.order.client.firstName} ${widget.order.client.lastName}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              kHalfSizedBox,
                              Text(
                                widget.order.client.phone,
                                style: TextStyle(
                                  color: kTextGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kHalfSizedBox,
                              FutureBuilder(
                                  future: getAddressFromCoordinates(
                                      '6.801965310155346', '7.092915443774477'),
                                  builder: (context, controller) {
                                    print(widget.order.orderitems.first.product
                                        .vendorId.id);
                                    return Text(
                                      controller.data ?? 'Loading',
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
                    Container(
                      margin: const EdgeInsets.only(right: 25),
                      child: InkWell(
                        onTap: toMapDirectionage,
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
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: CircleAvatar(
                        radius: deviceType(media.width) >= 2 ? 60 : 30,
                        child: ClipOval(
                          child: MyImage(url: widget.order.client.image),
                        ),
                      ),
                    ),
                    kWidthSizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.order.client.firstName} ${widget.order.client.lastName}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: kTextBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kHalfSizedBox,
                        Text(
                          widget.order.client.phone,
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kHalfSizedBox,
                        Text(
                          widget.order.deliveryAddress.details,
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
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
  }
}
