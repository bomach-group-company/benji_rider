import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../button/my_elevatedbutton.dart';

class EmptyCard extends StatelessWidget {
  final String emptyCardMessage;
  final String buttonTitle;
  final dynamic onPressed;
  final bool showButton;
  const EmptyCard({
    super.key,
    this.emptyCardMessage = "Oops! There is nothing here",
    this.buttonTitle = "",
    this.onPressed,
    this.showButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(kDefaultPadding),
      children: [
        Column(
          children: [
            Lottie.asset(
              "assets/animations/empty/frame_1.json",
            ),
            kSizedBox,
            Text(
              emptyCardMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextGreyColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            kSizedBox,
            showButton == false
                ? const SizedBox()
                : MyElevatedButton(
                    title: buttonTitle,
                    onPressed: onPressed ?? () {},
                  ),
          ],
        ),
      ],
    );
  }
}
