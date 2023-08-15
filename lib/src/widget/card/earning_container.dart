// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';

class EarningContainer extends StatefulWidget {
  final Function() onTap;
  final double number;
  final String typeOf;
  final String onlineStatus;
  final bool isVisibleCash;
  EarningContainer({
    super.key,
    required this.onTap,
    required this.number,
    required this.typeOf,
    required this.onlineStatus,
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
            Text(
              'Hi ${widget.typeOf},',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextBlackColor,
                fontSize: 15,
                fontWeight: FontWeight.w800,
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
                  onPressed: _changeCaseVisibility,
                  icon: Icon(
                      isVisibleCash! ? Icons.visibility : Icons.visibility_off),
                )
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
