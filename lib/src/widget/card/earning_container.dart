// ignore_for_file: file_names

import 'package:benji_rider/repo/utils/helpers.dart';
import 'package:benji_rider/src/widget/others/future_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/withdrawal/select_account.dart';
import '../../../repo/model/user_model.dart';
import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class EarningContainer extends StatefulWidget {
  final double accountBalance;
  EarningContainer({
    super.key,
    required this.accountBalance,
  });

  @override
  State<EarningContainer> createState() => _EarningContainerState();
}

class _EarningContainerState extends State<EarningContainer> {
  //======================================================= INITIAL STATE ================================================\\

  @override
  void initState() {
    super.initState();
  }

//======================================================= ALL VARIABLES ================================================\\

//======================================================= FUNCTIONS =================================================\\
  Future<Map> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isVisibleCash = await prefs.getBool('isVisibleCash');

    User? user = await getUser();
    return {'status': isVisibleCash ?? true, 'user': user};
  }

  Future<void> toggleVisibleCash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isVisibleCash = prefs.getBool('isVisibleCash') ?? true;
    await prefs.setBool('isVisibleCash', !isVisibleCash);

    setState(() {});
  }

  String formattedText(double value) {
    final numberFormat = NumberFormat('#,##0.00');
    return numberFormat.format(value);
  }

//======================================================= Navigation=================================================\\
  //To Select Account
  void _toSelectAccountPage() => Get.to(
        () => const SelectAccountPage(),
        routeName: 'SelectAccountPage',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding / 1.5,
        horizontal: kDefaultPadding,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
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
      child: MyFutureBuilder(
        future: _getData(),
        child: dashboardHead,
      ),
    );
  }

  Column dashboardHead(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Hi ${data['user'] != null ? data['user'].username : 'username'},",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: kTextBlackColor,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        kHalfSizedBox,
        Text(
          data['user'] != null ? data['user'].email : 'email',
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: kTextGreyColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          children: [
            Text(
              'Available Balance',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextBlackColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            kHalfWidthSizedBox,
            IconButton(
              onPressed: toggleVisibleCash,
              icon: Icon(
                data['status'] ? Icons.visibility : Icons.visibility_off,
                color: data['status'] ? kDefaultIconDarkColor : kAccentColor,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "₦",
                    style: const TextStyle(
                      color: kTextBlackColor,
                      fontSize: 20,
                      fontFamily: 'sen',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: data['status']
                        ? formattedText(widget.accountBalance)
                        : '******',
                    style: const TextStyle(
                      color: kTextBlackColor,
                      fontSize: 20,
                      fontFamily: 'sen',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _toSelectAccountPage,
                  icon: Icon(
                    Icons.payment,
                    color: kAccentColor,
                  ),
                ),
                Text(
                  "Withdraw",
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
