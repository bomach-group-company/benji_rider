// ignore_for_file:  unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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
    _loadingScreen = true;
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => setState(
        () => _loadingScreen = false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

//==========================================================================================\\

//=================================== ALL VARIABLES =====================================\\
  late bool _loadingScreen;

//============================================== CONTROLLERS =================================================\\
  final ScrollController _scrollController = ScrollController();

//=================================== FUNCTIONS =====================================\\

//===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _loadingScreen = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loadingScreen = false;
    });
  }

//=================================== Navigation =====================================\\

  void _toAccountPage() {}

  void _toRidersPage() {}

  void _toSeeAllNewOrders() {}

  void _toSeeAllActiveOrders() {}

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateAndTime = formatDateAndTime(now);
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    //===================== _changeCaseVisibility ================================\\
    Future<bool> _getCashVisibility() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isVisibleCash = await prefs.getBool('isVisibleCash');
      return isVisibleCash ?? true;
    }

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
              return _loadingScreen
                  ? SpinKitDoubleBounce(color: kAccentColor)
                  : Scrollbar(
                      controller: _scrollController,
                      radius: const Radius.circular(10),
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(kDefaultPadding),
                        children: [
                          FutureBuilder<bool>(
                            future: _getCashVisibility(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.requireData) {
                                return Center(
                                  child:
                                      SpinKitChasingDots(color: kAccentColor),
                                );
                              }
                              if (snapshot.hasData) {
                                return EarningContainer(
                                  onTap: _toAccountPage,
                                  number: 390.525,
                                  typeOf: "Emmanuel",
                                  onlineStatus: "248 Online",
                                  isVisibleCash: snapshot.data,
                                );
                              }
                              return EarningContainer(
                                onTap: _toAccountPage,
                                number: 390.525,
                                typeOf: "",
                                onlineStatus: "",
                                isVisibleCash: false,
                              );
                            },
                          ),
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
                            onTap: _toRidersPage,
                            number: "390",
                            typeOf: "Vendors",
                            onlineStatus: "248 Online",
                          ),
                          kSizedBox,
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
