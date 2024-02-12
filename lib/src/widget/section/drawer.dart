// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:benji_rider/app/auth/login.dart';
import 'package:benji_rider/app/order/orders.dart';
import 'package:benji_rider/app/package/packages.dart';
import 'package:benji_rider/app/vendors/vendors.dart';
import 'package:benji_rider/src/widget/image/my_image.dart';
import 'package:benji_rider/src/widget/others/my_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../app/dashboard/dashboard.dart';
import '../../../app/settings/settings.dart';
import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../providers/responsive_constant.dart';
import '../../repo/controller/order_controller.dart';
import '../../repo/controller/user_controller.dart';
import '../../repo/utils/helpers.dart';
import 'list_tile.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
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
      child: Padding(
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
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1.65,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  child: MyImage(url: UserController.instance.user.value.image),
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
            MyFutureBuilder(
              future: getUser(),
              child: headDrawer,
            ),
            kSizedBox,
            kSizedBox,
            kSizedBox,
            MyListTile(
              text: 'Dashboard',
              icon: Icons.grid_view_rounded,
              nav: () {
                Get.to(
                  () => const Dashboard(),
                  routeName: 'Dashboard',
                  duration: const Duration(milliseconds: 300),
                  fullscreenDialog: true,
                  curve: Curves.easeIn,
                  preventDuplicates: false,
                  popGesture: true,
                  transition: Transition.rightToLeft,
                );
              },
            ),
            MyListTile(
              text: 'My Orders',
              icon: Icons.map_outlined,
              nav: () {
                Get.to(
                  () => const Delivery(),
                  routeName: 'Delivery',
                  duration: const Duration(milliseconds: 300),
                  fullscreenDialog: true,
                  curve: Curves.easeIn,
                  preventDuplicates: false,
                  popGesture: true,
                  transition: Transition.rightToLeft,
                );
              },
            ),
            MyListTile(
              text: 'My Packages',
              icon: Icons.delivery_dining_sharp,
              nav: () {
                Get.to(
                  () => const Package(),
                  routeName: 'Package',
                  duration: const Duration(milliseconds: 300),
                  fullscreenDialog: true,
                  curve: Curves.easeIn,
                  preventDuplicates: false,
                  popGesture: true,
                  transition: Transition.rightToLeft,
                );
              },
            ),
            MyListTile(
              text: 'Vendors',
              icon: Icons.storefront,
              nav: () {
                Get.to(
                  () => const Vendors(),
                  routeName: 'Vendors',
                  duration: const Duration(milliseconds: 300),
                  fullscreenDialog: true,
                  curve: Curves.easeIn,
                  preventDuplicates: false,
                  popGesture: true,
                  transition: Transition.rightToLeft,
                );
              },
            ),
            MyListTile(
              text: 'Settings',
              icon: Icons.settings,
              nav: () {
                Get.to(
                  () => const SettingsPage(),
                  routeName: 'SettingsPage',
                  duration: const Duration(milliseconds: 300),
                  fullscreenDialog: true,
                  curve: Curves.easeIn,
                  preventDuplicates: false,
                  popGesture: true,
                  transition: Transition.rightToLeft,
                );
              },
            ),
            MyListTile(
              text: 'Logout',
              icon: Icons.logout,
              nav: () {
                UserController.instance.deleteUser();
                OrderController.instance.deleteCachedOrders();
                Get.offAll(
                  () => const Login(),
                  predicate: (route) => false,
                  routeName: 'Login',
                  duration: const Duration(milliseconds: 300),
                  fullscreenDialog: true,
                  curve: Curves.easeIn,
                  popGesture: true,
                  transition: Transition.rightToLeft,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container headDrawer(data) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: kDefaultPadding),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.username,
            softWrap: true,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 19.86,
              fontWeight: FontWeight.w700,
            ),
          ),
          kHalfSizedBox,
          Text(
            data.email,
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF929292),
              fontSize: 15.44,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
