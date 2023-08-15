// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:benji_rider/app/auth/login.dart';
import 'package:benji_rider/app/earning/earning.dart';
import 'package:benji_rider/app/rider/rider.dart';

import 'package:benji_rider/app/withdrawal/withdraw_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/dashboard/dashboard.dart';
import '../../../app/delivery/history.dart';
import '../../../app/withdrawal/select_account.dart';
import '../../../theme/colors.dart';
import '../../../theme/responsive_constant.dart';
import '../../providers/constants.dart';
import 'list_tile.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future<bool> _getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isOnline = await prefs.getBool('isOnline');
    return isOnline ?? false;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> toggleOnline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isOnline = prefs.getBool('isOnline') ?? false;
    await prefs.setBool('isOnline', !isOnline);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: kPrimaryColor,
      elevation: 10.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
        ),
      ),
      width: breakPoint(media.width, media.width * 0.8, 400, 400, 400),
      child: FutureBuilder(
          future: _getStatus(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SpinKitChasingDots(
                  color: kAccentColor,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 106.67,
                          height: 107.68,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/profile/avatar_image.jpg"),
                              fit: BoxFit.cover,
                            ),
                            shape: OvalBorder(
                              side: BorderSide(
                                width: 1.65,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: ShapeDecoration(
                              color: kAccentColor,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  color: kAccentColor,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: kTextWhiteColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: kDefaultPadding),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Princewill Okafor',
                            softWrap: true,
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 19.86,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          kHalfSizedBox,
                          Text(
                            'princewillokafor@gmail.com',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 15.44,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    kSizedBox,
                    kSizedBox,
                    kSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data ? 'Online' : 'Offline',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF232323),
                            fontSize: 26.47,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          splashRadius: 5,
                          onPressed: toggleOnline,
                          icon: Icon(
                            snapshot.data ? Icons.toggle_on : Icons.toggle_off,
                            color: snapshot.data
                                ? kAccentColor
                                : const Color(0xFF8D8D8D),
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    kSizedBox,
                    MyListTile(
                      text: 'Dashboard',
                      isOnline: snapshot.data,
                      icon: Icons.speed_outlined,
                      nav: () {
                        Get.to(
                          () => Dashboard(),
                          routeName: 'Dashboard',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                    MyListTile(
                      text: 'Ride',
                      isOnline: snapshot.data,
                      icon: Icons.pedal_bike,
                      nav: () {
                        Get.to(
                          () => const RiderPage(),
                          routeName: 'RiderPage',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                    MyListTile(
                      text: 'Vendors',
                      isOnline: snapshot.data,
                      icon: Icons.sell_outlined,
                      nav: () {},
                    ),
                    MyListTile(
                      text: 'Earnings',
                      isOnline: snapshot.data,
                      icon: Icons.money,
                      nav: () {
                        Get.to(
                          () => const Earning(),
                          routeName: 'Earning',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                    MyListTile(
                      text: 'Withdraw',
                      isOnline: snapshot.data,
                      icon: Icons.payments_outlined,
                      nav: () {
                        Get.to(
                          () => const SelectAccountPage(),
                          routeName: 'SelectAccountPage',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                    MyListTile(
                      text: 'Withdraw History',
                      isOnline: snapshot.data,
                      icon: Icons.history,
                      nav: () {
                        Get.to(
                          () => const WithdrawHistoryPage(),
                          routeName: 'WithdrawHistoryPage',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                    MyListTile(
                      text: 'Delivery History',
                      isOnline: snapshot.data,
                      icon: Icons.location_on_outlined,
                      nav: () {
                        Get.off(
                          () => const DeliveredHistory(),
                          routeName: 'DeliveredHistory',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                    MyListTile(
                      text: 'Help & Support',
                      isOnline: snapshot.data,
                      icon: Icons.question_mark_outlined,
                      nav: () {},
                    ),
                    MyListTile(
                      text: 'Settings',
                      isOnline: snapshot.data,
                      icon: Icons.settings,
                      nav: () {},
                    ),
                    MyListTile(
                      text: 'Logout',
                      isOnline: snapshot.data,
                      icon: Icons.logout,
                      nav: () {
                        Get.off(
                          () => const Login(logout: true),
                          routeName: 'Login',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
