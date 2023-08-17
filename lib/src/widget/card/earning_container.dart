// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/withdrawal/select_account.dart';
import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class EarningContainer extends StatefulWidget {
  final Function()? onTap;
  final double number;
  final bool isVisibleCash;
  EarningContainer({
    super.key,
    this.onTap,
    required this.number,
    this.isVisibleCash = true,
  });

  @override
  State<EarningContainer> createState() => _EarningContainerState();
}

class _EarningContainerState extends State<EarningContainer> {
  bool? isVisibleCash;

  void _changeCaseVisibility() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isVisibleCash', !isVisibleCash!);

    setState(() {
      isVisibleCash = !isVisibleCash!;
    });
  }

  @override
  void initState() {
    isVisibleCash = widget.isVisibleCash;
    super.initState();
  }

//======================================================= FUNCTIONS =================================================\\

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
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(kDefaultPadding),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  onPressed: _changeCaseVisibility,
                  icon: Icon(
                      isVisibleCash! ? Icons.visibility : Icons.visibility_off),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isVisibleCash!
                      ? '₦ ${widget.number.toStringAsFixed(2)}'
                      : '******',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kTextBlackColor,
                    fontSize: 20,
                    fontFamily: 'sen',
                    fontWeight: FontWeight.w700,
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
        ),
      ),
    );
  }
}
