// ignore_for_file: file_names

import 'package:benji_rider/main.dart';
import 'package:benji_rider/src/widget/others/my_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../app/withdrawal/select_account.dart';
import '../../../theme/colors.dart';
import '../../providers/constants.dart';
import '../../repo/controller/user_controller.dart';
import '../../repo/models/user_model.dart';
import '../../repo/utils/helpers.dart';

class EarningContainer extends StatefulWidget {
  const EarningContainer({
    super.key,
  });

  @override
  State<EarningContainer> createState() => _EarningContainerState();
}

class _EarningContainerState extends State<EarningContainer> {
  //======================================================= INITIAL STATE ================================================\\

  @override
  void initState() {
    super.initState();
    _getData();
  }

//======================================================= ALL VARIABLES ================================================\\

//======================================================= FUNCTIONS =================================================\\
  Future<Map> _getData() async {
    bool? isVisibleCash = prefs.getBool('isVisibleCash');

    User? user = await getUser();
    return {'status': isVisibleCash ?? true, 'user': user};
  }

  Future<void> toggleVisibleCash() async {
    bool isVisibleCash = prefs.getBool('isVisibleCash') ?? true;
    await prefs.setBool('isVisibleCash', !isVisibleCash);

    UserController.instance.setUserSync();
  }

//======================================================= Navigation=================================================\\
  //To Select Account
  void toSelectAccount() => Get.to(
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
          "Hi ${data['user'].firstName} ${data['user'].lastName},",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: kTextBlackColor,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        kHalfSizedBox,
        Text(
          data['user'].email,
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
            const Text(
              'Available Balance',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextBlackColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            kHalfWidthSizedBox,
            GetBuilder<UserController>(
              init: UserController(),
              builder: (controller) => IconButton(
                onPressed: toggleVisibleCash,
                icon: FaIcon(
                  controller.user.value.isVisibleCash
                      ? FontAwesomeIcons.solidEye
                      : FontAwesomeIcons.solidEyeSlash,
                  color: data['status'] ? kAccentColor : kAccentColor,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GetBuilder<UserController>(
                  init: UserController(),
                  builder: (controller) => controller.isLoading.value
                      ? Text(
                          'Loading...',
                          style: TextStyle(
                            color: kGreyColor,
                            fontSize: 20,
                            fontFamily: 'sen',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "₦",
                                style: TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 20,
                                  fontFamily: 'sen',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: controller.user.value.isVisibleCash
                                    ? formattedText(
                                        controller.user.value.balance)
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
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.arrowsRotate,
                    color: kAccentColor,
                  ),
                  onPressed: () async {
                    await UserController.instance.getUser();
                  },
                  color: kGreyColor,
                  iconSize: 25.0,
                  tooltip: 'Refresh',
                  padding: const EdgeInsets.all(10.0),
                  splashRadius: 20.0,
                  splashColor: Colors.blue,
                  highlightColor: Colors.transparent,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: toSelectAccount,
                  icon: FaIcon(
                    FontAwesomeIcons.solidCreditCard,
                    color: kAccentColor,
                  ),
                ),
                InkWell(
                  onTap: toSelectAccount,
                  child: const Text(
                    "Withdraw",
                    style: TextStyle(
                      color: kTextBlackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
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
