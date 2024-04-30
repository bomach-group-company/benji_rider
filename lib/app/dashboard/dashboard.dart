// ignore_for_file:  unused_local_variable

import 'dart:async';

import 'package:benji_rider/app/businesses/businesses.dart';
import 'package:benji_rider/app/order/order_details.dart';
import 'package:benji_rider/app/package/package_detail.dart';
import 'package:benji_rider/src/repo/controller/user_controller.dart';
import 'package:benji_rider/src/widget/button/my_elevated_oval_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/business_controller.dart';
import '../../src/repo/controller/order_status_change.dart';
import '../../src/repo/controller/package_controller.dart';
import '../../src/repo/controller/tasks_controller.dart';
import '../../src/repo/models/delivery_model.dart';
import '../../src/repo/utils/map_stuff.dart';
import '../../src/widget/card/dashboard_rider_vendor_container.dart';
import '../../src/widget/card/earning_container.dart';
import '../../src/widget/section/drawer.dart';
import '../../src/widget/section/my_liquid_refresh.dart';
import '../../theme/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

typedef ModalContentBuilder = Widget Function(BuildContext);

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  //===================== Initial State ==========================\\
  void _toDetailsPage(DeliveryModel task) async {
    if (task.isOrder()) {
      await OrderStatusChangeController.instance.setOrder(task);

      Get.to(
        () => const OrderDetails(),
        routeName: 'OrderDetails',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
    } else {
      await PackageController.instance.setPackage(task);
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
  }

  @override
  void initState() {
    // tasks
    TasksController.instance.getTasksSocket();

    // coordinates
    TasksController.instance.getCoordinatesSocket();

    //Get vnendors
    BusinessController.instance.getAllBusinesses();

    super.initState();
  }

  @override
  void dispose() {
    TasksController.instance.closeTaskSocket();

    super.dispose();
  }

//==========================================================================================\\

//=================================== ALL VARIABLES =====================================\\

//============================================== CONTROLLERS =================================================\\
  final ScrollController _scrollController = ScrollController();

//=================================== FUNCTIONS =====================================\\

//===================== Handle refresh ==========================\\

  Future<void> handleRefresh() async {
    UserController.instance.setUserSync();
    // tasks
    TasksController.instance.getTasksSocket();

    // coordinates
    TasksController.instance.getCoordinatesSocket();

    //Get vnendors
    BusinessController.instance.getAllBusinesses();
  }

//=================================== Navigation =====================================\\

  // void _toSeeAllNewOrders() {}

  void toSeeAllVendors() => Get.to(
        () => const Businesses(),
        routeName: 'Businesses',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  // void _deliveryRoute(StatusType status) => Get.to(
  //       () => Delivery(status: status),
  //       routeName: 'Delivery',
  //       duration: const Duration(milliseconds: 300),
  //       fullscreenDialog: true,
  //       curve: Curves.easeIn,
  //       preventDuplicates: true,
  //       popGesture: true,
  //       transition: Transition.rightToLeft,
  //     );

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateAndTime = formatDateAndTime(now);
    var media = MediaQuery.of(context).size;

//====================================================================================\\

    return MyLiquidRefresh(
      onRefresh: handleRefresh,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: -20,
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          actions: [
            GetBuilder<UserController>(
              builder: (controller) {
                return Row(
                  children: [
                    controller.user.value.isOnline
                        ? Text(
                            'Online',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: controller.isLoadingOnline.value
                                  ? kBlackColor.withOpacity(0.5)
                                  : kBlackColor,
                            ),
                          )
                        : Text(
                            'Offline',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: controller.isLoadingOnline.value
                                  ? kBlackColor.withOpacity(0.5)
                                  : kBlackColor,
                            ),
                          ),
                    kHalfSizedBox,
                    Transform.scale(
                      scale: 0.8, // Adjust the scale factor as needed
                      child: Switch(
                        activeColor: Colors.green.withOpacity(0.8),
                        value: controller.user.value.isOnline,
                        onChanged: controller.isLoadingOnline.value
                            ? null
                            : (value) {
                                controller.setUserStatus(
                                    !controller.user.value.isOnline);
                              },
                      ),
                    ),
                    kWidthSizedBox,
                  ],
                );
              },
            )
          ],
          title: Container(
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Builder(
              builder: (context) => Row(
                children: [
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: kAccentColor,
                    ),
                  ),
                  kHalfWidthSizedBox,
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kBlackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: const MyDrawer(),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Scrollbar(
            controller: _scrollController,
            radius: const Radius.circular(10),
            scrollbarOrientation: ScrollbarOrientation.right,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(kDefaultPadding),
              children: [
                const EarningContainer(),
                kSizedBox,
                GetBuilder<BusinessController>(
                  builder: (controller) => RiderVendorContainer(
                    onTap: toSeeAllVendors,
                    number:
                        controller.isLoad.value && controller.businesses.isEmpty
                            ? "..."
                            : controller.businesses.length >= 10
                                ? '10+'
                                : controller.businesses.length.toString(),
                    typeOf: "Businesses",
                  ),
                ),
                kSizedBox,
                const Text(
                  'Incoming Tasks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                kSizedBox,
                GetBuilder<TasksController>(builder: (controller) {
                  if (controller.tasks.isEmpty) {
                    return Container(
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No Delivery Requests',
                            style: TextStyle(
                              color: kBlackColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          kSizedBox,
                          Text(
                            'You have No Delivery Requests For Now',
                            style: TextStyle(
                              color: kTextWhiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => kSizedBox,
                    shrinkWrap: true,
                    itemCount: controller.tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
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
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 24,
                              offset: Offset(0, 4),
                              spreadRadius: 4,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#${controller.tasks[index].id.substring(0, 8)}... - ${controller.tasks[index].isOrder() ? controller.tasks[index].order.orderitems.length : controller.tasks[index].package.itemQuantity} items',
                              style: const TextStyle(
                                color: kBlackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            kSizedBox,
                            controller.tasks[index].order.orderitems.isEmpty &&
                                    controller.tasks[index].isOrder()
                                ? const Text('Pickup from - Not Found')
                                : FutureBuilder(
                                    future: controller.tasks[index].isOrder()
                                        ? getAddressFromCoordinates(
                                            controller
                                                .tasks[index]
                                                .order
                                                .orderitems
                                                .first
                                                .product
                                                .vendorId
                                                .latitude,
                                            controller
                                                .tasks[index]
                                                .order
                                                .orderitems
                                                .first
                                                .product
                                                .vendorId
                                                .longitude)
                                        : getAddressFromCoordinates(
                                            controller.tasks[index].package
                                                .pickUpAddressLatitude,
                                            controller.tasks[index].package
                                                .pickUpAddressLongitude,
                                          ),
                                    builder: (context, controller) {
                                      return Text(
                                        controller.data == null
                                            ? 'Loading...'
                                            : 'Pickup from - ${controller.data!}',
                                      );
                                    }),
                            kHalfSizedBox,
                            FutureBuilder(
                                future: controller.tasks[index].isOrder()
                                    ? getAddressFromCoordinates(
                                        controller.tasks[index].order
                                            .deliveryAddress.latitude,
                                        controller.tasks[index].order
                                            .deliveryAddress.longitude)
                                    : getAddressFromCoordinates(
                                        controller.tasks[index].package
                                            .dropOffAddressLatitude,
                                        controller.tasks[index].package
                                            .dropOffAddressLongitude,
                                      ),
                                builder: (context, controller) {
                                  return Text(
                                    controller.data == null
                                        ? 'Loading...'
                                        : 'Deliver to - ${controller.data!}',
                                  );
                                }),
                            kSizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyElevatedOvalButton(
                                  title: 'Reject',
                                  onPressed: () {
                                    controller
                                        .rejectTask(controller.tasks[index].id);
                                  },
                                  isLoading: controller.isLoading.value,
                                ),
                                MyElevatedOvalButton(
                                  title: 'Accept',
                                  onPressed: () async {
                                    DeliveryModel task =
                                        controller.tasks[index];
                                    await controller
                                        .acceptTask(controller.tasks[index].id);

                                    while (controller.isLoading.value) {
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                    }
                                    if (!controller.isLoading.value) {
                                      // print(
                                      //     ' got to the func later ${controller.isLoading.value} chai');
                                      _toDetailsPage(task);
                                    }
                                  },
                                  isLoading: controller.isLoading.value,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
                kSizedBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}
