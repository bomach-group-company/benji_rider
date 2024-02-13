import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/order_controller.dart';
import '../../src/repo/controller/user_controller.dart';
import '../../src/widget/section/profile_first_half.dart';
import '../../theme/colors.dart';
import '../auth/login.dart';
import '../withdrawal/withdrawal_history.dart';
import 'help_n_support.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //==================================================  INITIAL STATE ======================================================\\
  @override
  void initState() {
    super.initState();
  }

  //==================================================  ALL VARIABLES ======================================================\\
  final double accountBalance = 1000000.00;

  //==================================================  Navigation ======================================================\\

  void _toHelpAndSupportPage() => Get.to(
        () => const HelpNSupport(),
        routeName: 'HelpNSupport',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    // //===================== _changeCaseVisibility ================================\\
    // Future<bool> _getCashVisibility() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   bool? isVisibleCash = await prefs.getBool('isVisibleCash');
    //   return isVisibleCash ?? true;
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccentColor,
        title: Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding),
          child: Text(
            'Settings',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const ProfileFirstHalf(),
            Padding(
              padding: const EdgeInsets.only(
                top: kDefaultPadding / 1.5,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding / 1.5,
              ),
              child: Container(
                padding: const EdgeInsets.all(
                  kDefaultPadding / 2,
                ),
                decoration: ShapeDecoration(
                  color: Colors.white,
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
                  children: [
                    ListTile(
                      onTap: () {
                        Get.to(
                          () => const WithdrawalHistoryPage(),
                          routeName: 'WithdrawalHistoryPage',
                          duration: const Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          curve: Curves.easeIn,
                          preventDuplicates: true,
                          popGesture: true,
                          transition: Transition.rightToLeft,
                        );
                      },
                      leading: FaIcon(
                        FontAwesomeIcons.clockRotateLeft,
                        color: kAccentColor,
                      ),
                      title: const Text(
                        'Withdrawal History',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: 14,
                      ),
                    ),
                    ListTile(
                      onTap: _toHelpAndSupportPage,
                      leading: FaIcon(
                        FontAwesomeIcons.solidCircleQuestion,
                        color: kAccentColor,
                      ),
                      title: const Text(
                        'Help & Support',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding / 1.5,
              ),
              child: Container(
                width: 327,
                height: 78,
                padding: const EdgeInsets.all(
                  kDefaultPadding / 2,
                ),
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
                child: ListTile(
                  onTap: () {
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
                  leading: FaIcon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    color: kAccentColor,
                  ),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: kTextBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
