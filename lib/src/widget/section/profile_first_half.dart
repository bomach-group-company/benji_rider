// ignore_for_file: file_names

import 'package:benji_rider/main.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:benji_rider/src/widget/others/my_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/withdrawal/select_account.dart';
import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class ProfileFirstHalf extends StatefulWidget {
  const ProfileFirstHalf({
    super.key,
  });

  @override
  State<ProfileFirstHalf> createState() => _ProfileFirstHalfState();
}

class _ProfileFirstHalfState extends State<ProfileFirstHalf> {
  //======================================================= INITIAL STATE ================================================\\

  @override
  void initState() {
    super.initState();
  }

//======================================================= ALL VARIABLES ================================================\\

//======================================================= FUNCTIONS =================================================\\

  Future<bool> _getStatusCash() async {
    bool? isVisibleCash = await prefs.getBool('isVisibleCash');
    return isVisibleCash ?? true;
  }

  Future<void> toggleVisibleCash() async {
    bool isVisibleCash = prefs.getBool('isVisibleCash') ?? true;
    await prefs.setBool('isVisibleCash', !isVisibleCash);

    setState(() {});
  }

  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0.00');
    return numberFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      padding: const EdgeInsets.only(top: kDefaultPadding),
      decoration: ShapeDecoration(
        color: kAccentColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      child: MyFutureBuilder(
        future: _getStatusCash(),
        child: profileHead,
      ),
    );
  }

  Column profileHead(data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Available Balance',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            IconButton(
              onPressed: toggleVisibleCash,
              icon: Icon(
                data ? Icons.visibility : Icons.visibility_off,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
        kSizedBox,
        GetBuilder<UserController>(
          init: UserController(),
          builder: (controller) => Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "₦",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontFamily: 'sen',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: data
                      ? formattedText(controller.user.value.balance)
                      : '******',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        kSizedBox,
        InkWell(
          onTap: () {
            Get.to(
              () => SelectAccountPage(),
              routeName: 'SelectAccountPage',
              duration: const Duration(milliseconds: 300),
              fullscreenDialog: true,
              curve: Curves.easeIn,
              preventDuplicates: true,
              popGesture: true,
              transition: Transition.rightToLeft,
            );
          },
          child: Container(
            width: 100,
            height: 37,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Withdraw',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: kDefaultPadding * 2,
        ),
      ],
    );
  }
}
