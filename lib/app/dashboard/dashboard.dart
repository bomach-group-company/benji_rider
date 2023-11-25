// ignore_for_file:  unused_local_variable

import 'dart:async';

import 'package:benji_rider/app/vendors/vendors.dart';
import 'package:benji_rider/repo/controller/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../repo/controller/vendor_controller.dart';
import '../../src/providers/constants.dart';
import '../../src/widget/card/dashboard_rider_vendor_container.dart';
import '../../src/widget/card/earning_container.dart';
import '../../src/widget/section/drawer.dart';
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

  @override
  void initState() {
    // tasks
    TasksController.instance.getTasksSocket();

    // coordinates
    TasksController.instance.getCoordinatesSocket();

    //Get vnendors
    VendorController.instance.getVendorList();

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

  Future<void> _handleRefresh() async {}

//=================================== Navigation =====================================\\

  // void _toSeeAllNewOrders() {}

  void toSeeAllVendors() => Get.to(
        () => const Vendors(),
        routeName: 'Vendors',
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
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

//====================================================================================\\

    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      color: kAccentColor,
      borderWidth: 5.0,
      backgroundColor: kPrimaryColor,
      height: 150,
      animSpeedFactor: 2,
      showChildOpacityTransition: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: -20,
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     OrdersContainer(
                //       containerColor: kPrimaryColor,
                //       typeOfOrderColor: kTextGreyColor,
                //       iconColor: kGreyColor1,
                //       numberOfOrders: "47",
                //       typeOfOrders: "Completed",
                //       onTap: () => _deliveryRoute(StatusType.delivered),
                //     ),
                //     OrdersContainer(
                //       containerColor: Colors.red.shade100,
                //       typeOfOrderColor: kAccentColor,
                //       iconColor: kAccentColor,
                //       numberOfOrders: "3",
                //       typeOfOrders: "Pending",
                //       onTap: () => _deliveryRoute(StatusType.pending),
                //     ),
                //   ],
                // ),
                // kSizedBox,
                GetBuilder<VendorController>(
                  builder: (controller) => RiderVendorContainer(
                    onTap: toSeeAllVendors,
                    number: controller.total.value.toString(),
                    typeOf: "Vendors",
                  ),
                ),
                kSizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
