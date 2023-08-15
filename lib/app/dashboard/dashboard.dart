// ignore_for_file:  unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/card/dashboard_orders_container.dart';
import '../../src/widget/card/dashboard_rider_vendor_container.dart';
import '../../src/widget/card/earning_container.dart';
import '../../src/widget/section/drawer.dart';
import '../../theme/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

typedef ModalContentBuilder = Widget Function(BuildContext);

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  //===================== Initial State ==========================\\
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//==========================================================================================\\

//=================================== ALL VARIABLES =====================================\\
  bool _isScrollToTopBtnVisible = false;
  int incrementOrderID = 2 + 2;
  late int orderID;
  String orderItem = "Jollof Rice and Chicken";
  String customerAddress = "21 Odogwu Street, New Haven";
  int itemQuantity = 2;
  double price = 2500;
  double itemPrice = 2500;
  String orderImage = "chizzy's-food";
  String customerName = "Mercy Luke";

//============================================== CONTROLLERS =================================================\\
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

//=================================== FUNCTIONS =====================================\\

  double calculateSubtotal() {
    return itemPrice * itemQuantity;
  }

//============================= Scroll to Top ======================================//
  void _scrollToTop() {
    _animationController.reverse();
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

//=================================== Navigation =====================================\\

  void _toSeeAllVendors() {}

  void _toSeeAllNewOrders() {}

  void _toSeeAllActiveOrders() {}

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateAndTime = formatDateAndTime(now);
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    double subtotalPrice = calculateSubtotal();

    //===================== _changeCaseVisibility ================================\\
    Future<bool> _getCashVisibility() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isVisibleCash = await prefs.getBool('isVisibleCash');
      return isVisibleCash ?? true;
    }

//====================================================================================\\

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: -20,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
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
                Text(
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
      drawer: MyDrawer(),
      floatingActionButton: Stack(
        children: <Widget>[
          if (_isScrollToTopBtnVisible) ...[
            ScaleTransition(
              scale: CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.fastEaseInToSlowEaseOut),
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                mini: true,
                backgroundColor: kAccentColor,
                enableFeedback: true,
                mouseCursor: SystemMouseCursors.click,
                tooltip: "Scroll to top",
                hoverColor: kAccentColor,
                hoverElevation: 50.0,
                child: const Icon(Icons.keyboard_arrow_up),
              ),
            ),
          ]
        ],
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(
                child: Text("Loading..."),
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              const Center(
                child: Text("Please connect to the internet"),
              );
            }
            // if (snapshot.connectionState == snapshot.requireData) {
            //   SpinKitDoubleBounce(color: kAccentColor);
            // }
            if (snapshot.connectionState == snapshot.error) {
              const Center(
                child: Text("Error, Please try again later"),
              );
            }
            return Scrollbar(
              controller: _scrollController,
              radius: const Radius.circular(10),
              scrollbarOrientation: ScrollbarOrientation.right,
              child: ListView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(kDefaultPadding),
                children: [
                  FutureBuilder(
                      future: _getCashVisibility(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return EarningContainer(
                            onTap: _toSeeAllVendors,
                            number: 390.525,
                            typeOf: "Emmanuel",
                            onlineStatus: "248 Online",
                            isVisibleCash: snapshot.data,
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
                  kSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OrdersContainer(
                        containerColor: kPrimaryColor,
                        typeOfOrderColor: kTextGreyColor,
                        iconColor: kGreyColor1,
                        numberOfOrders: "47",
                        typeOfOrders: "Completed",
                        onTap: _toSeeAllActiveOrders,
                      ),
                      OrdersContainer(
                        containerColor: Colors.red.shade100,
                        typeOfOrderColor: kAccentColor,
                        iconColor: kAccentColor,
                        numberOfOrders: "3",
                        typeOfOrders: "Pending",
                        onTap: _toSeeAllNewOrders,
                      ),
                    ],
                  ),
                  kSizedBox,
                  RiderVendorContainer(
                    onTap: _toSeeAllVendors,
                    number: "390",
                    typeOf: "Vendors",
                    onlineStatus: "248 Online",
                  ),
                  kSizedBox,
                  // RiderVendorContainer(
                  //   onTap: _toSeeAllRiders,
                  //   number: "90",
                  //   typeOf: "Riders",
                  //   onlineStatus: "32 Online",
                  // ),
                  // const SizedBox(height: kDefaultPadding * 2),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const SizedBox(
                  //       width: 200,
                  //       child: Text(
                  //         "New Orders",
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //       ),
                  //     ),
                  //     TextButton(
                  //       onPressed: _toSeeAllNewOrders,
                  //       child: SizedBox(
                  //         child: Text(
                  //           "See All",
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             color: kAccentColor,
                  //             fontWeight: FontWeight.w400,
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // kSizedBox,
                  //   Column(
                  //     children: [
                  //       for (orderID = 1;
                  //           orderID < 30;
                  //           orderID += incrementOrderID)
                  //         InkWell(
                  //           onTap: toOrderDetailsPage,
                  //           borderRadius: BorderRadius.circular(kDefaultPadding),
                  //           child: Container(
                  //             margin: const EdgeInsets.symmetric(
                  //               vertical: kDefaultPadding / 2,
                  //             ),
                  //             padding: const EdgeInsets.only(
                  //               top: kDefaultPadding / 2,
                  //               left: kDefaultPadding / 2,
                  //               right: kDefaultPadding / 2,
                  //             ),
                  //             width: mediaWidth / 1.1,
                  //             height: 150,
                  //             decoration: ShapeDecoration(
                  //               color: kPrimaryColor,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius:
                  //                     BorderRadius.circular(kDefaultPadding),
                  //               ),
                  //               shadows: const [
                  //                 BoxShadow(
                  //                   color: Color(0x0F000000),
                  //                   blurRadius: 24,
                  //                   offset: Offset(0, 4),
                  //                   spreadRadius: 4,
                  //                 ),
                  //               ],
                  //             ),
                  //             child: Row(
                  //               children: [
                  //                 Column(
                  //                   children: [
                  //                     Container(
                  //                       width: 60,
                  //                       height: 60,
                  //                       decoration: BoxDecoration(
                  //                         color: kPageSkeletonColor,
                  //                         borderRadius: BorderRadius.circular(16),
                  //                         image: DecorationImage(
                  //                           image: AssetImage(
                  //                             "assets/images/products/$orderImage.png",
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     kHalfSizedBox,
                  //                     Text(
                  //                       "#00${orderID.toString()}",
                  //                       style: TextStyle(
                  //                         color: kTextGreyColor,
                  //                         fontSize: 13,
                  //                         fontWeight: FontWeight.w400,
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 kWidthSizedBox,
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     SizedBox(
                  //                       width: mediaWidth / 1.55,
                  //                       // color: kAccentColor,
                  //                       child: Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                         children: [
                  //                           const SizedBox(
                  //                             child: Text(
                  //                               "Hot Kitchen",
                  //                               maxLines: 2,
                  //                               overflow: TextOverflow.ellipsis,
                  //                               style: TextStyle(
                  //                                 fontSize: 12,
                  //                                 fontWeight: FontWeight.w400,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             child: Text(
                  //                               formattedDateAndTime,
                  //                               overflow: TextOverflow.ellipsis,
                  //                               style: const TextStyle(
                  //                                 fontSize: 12,
                  //                                 fontWeight: FontWeight.w400,
                  //                               ),
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     kHalfSizedBox,
                  //                     Container(
                  //                       color: kTransparentColor,
                  //                       width: 250,
                  //                       child: Text(
                  //                         orderItem,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         maxLines: 2,
                  //                         style: const TextStyle(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.w700,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     kHalfSizedBox,
                  //                     Container(
                  //                       width: 200,
                  //                       color: kTransparentColor,
                  //                       child: Text.rich(
                  //                         TextSpan(
                  //                           children: [
                  //                             TextSpan(
                  //                               text: "x $itemQuantity",
                  //                               style: const TextStyle(
                  //                                 fontSize: 13,
                  //                                 fontWeight: FontWeight.w400,
                  //                               ),
                  //                             ),
                  //                             const TextSpan(text: "  "),
                  //                             TextSpan(
                  //                               text:
                  //                                   "₦ ${itemPrice.toStringAsFixed(2)}",
                  //                               style: const TextStyle(
                  //                                 fontSize: 15,
                  //                                 fontFamily: 'sen',
                  //                                 fontWeight: FontWeight.w400,
                  //                               ),
                  //                             )
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     kHalfSizedBox,
                  //                     Container(
                  //                       color: kGreyColor1,
                  //                       height: 1,
                  //                       width: mediaWidth / 1.8,
                  //                     ),
                  //                     kHalfSizedBox,
                  //                     SizedBox(
                  //                       width: mediaWidth / 1.8,
                  //                       child: Text(
                  //                         customerName,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         maxLines: 1,
                  //                         style: const TextStyle(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.w700,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: mediaWidth / 1.8,
                  //                       child: Text(
                  //                         customerAddress,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         maxLines: 1,
                  //                         style: const TextStyle(
                  //                           fontSize: 13,
                  //                           fontWeight: FontWeight.w400,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //     ],
                  //   ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
