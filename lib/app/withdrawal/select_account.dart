import 'package:benji_rider/app/withdrawal/withdraw.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';
import 'add_bank_account.dart';

class SelectAccountPage extends StatefulWidget {
  const SelectAccountPage({super.key});

  @override
  State<SelectAccountPage> createState() => _SelectAccountPageState();
}

class _SelectAccountPageState extends State<SelectAccountPage> {
//===================================== ALL =========================================\\

  void _goToWithdraw() {
    Get.to(
      () => const WithdrawPage(),
      routeName: 'WithdrawPage',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  _addNewAccount() => Get.to(
        () => const AddBankAccountPage(),
        routeName: 'AddBankAccountPage',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "Select Account",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(kDefaultPadding),
              separatorBuilder: (context, index) => kSizedBox,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: _goToWithdraw,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey.shade400,
                          spreadRadius: 1,
                          // offset: Offset(1, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/icons/accessbank.png'),
                                kHalfWidthSizedBox,
                                const Text(
                                  'Access Bank',
                                  style: TextStyle(
                                    color: Color(0xFF979797),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                _showBottomSheet(context);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.ellipsis,
                                color: kAccentColor,
                              ),
                            )
                          ],
                        ),
                        kSizedBox,
                        const Text(
                          'Blessing George....09876',
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            kHalfSizedBox,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEF8F8),
                      minimumSize: const Size(double.infinity, 60)),
                  onPressed: _addNewAccount,
                  child: Text(
                    'Add a new Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(kDefaultPadding),
              child: InkWell(
                onTap: () {},
                mouseCursor: SystemMouseCursors.click,
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidTrashCan,
                        color: kAccentColor,
                        size: 18,
                      ),
                      kWidthSizedBox,
                      const Text(
                        'Delete account',
                        style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
