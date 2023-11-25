import 'package:benji_rider/src/widget/responsive/reponsive_width.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../repo/controller/withdraw_controller.dart';
import '../../src/providers/constants.dart';
import '../../src/widget/button/my_elevatedbutton.dart';
import '../../src/widget/form_and_auth/my textformfield.dart';
import '../../src/widget/form_and_auth/my_blue_textformfield.dart';
import '../../src/widget/section/my_appbar.dart';
import '../../theme/colors.dart';
import 'select_bank.dart';

class AddBankAccountPage extends StatefulWidget {
  const AddBankAccountPage({super.key});

  @override
  State<AddBankAccountPage> createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
//===================================== INITIAL STATE =========================================\\
  @override
  void initState() {
    super.initState();
    WithdrawController.instance.listBanks();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

//===================================== ALL VARIABLES =========================================\\

//===================================== BOOL VALUES =========================================\\
  bool isVisible = false;

//================= Controllers ==================\\
  final scrollController = ScrollController();
  final bankNameEC = TextEditingController();
  final accountNumberEC = TextEditingController();

//================= Focus Nodes ==================\\
  final bankNameFN = FocusNode();
  final bankNames = FocusNode();
  final accountNumberFN = FocusNode();

  final formKey = GlobalKey<FormState>();

  String bankCode = "";

  //================================== FUNCTION ====================================\\

  //=================================== Navigation ============================\\
  selectBank() async {
    final result = await Get.to(
      () => const SelectBank(),
      routeName: 'SelectBank',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.downToUp,
    );
    if (result != null) {
      final newBankName = result['name'];
      final newBankCode = result['code'];

      setState(() {
        bankNameEC.text = newBankName;
        bankCode = newBankCode;
      });

      consoleLog(newBankCode);
      consoleLog("Bank code: $bankCode");
    }
  }

  void saveAccount() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "Add bank account",
          elevation: 0,
          actions: const [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: kAccentColor.withOpacity(0.08),
              offset: const Offset(3, 0),
              blurRadius: 32,
            ),
          ]),
          child: MyElevatedButton(
            title: "Save Account",
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                saveAccount();
              }
            },
            // isLoading: controller.isLoad.value,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kDefaultPadding),
            physics: const BouncingScrollPhysics(),
            child: MyResponsiveWidth(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Center(
                    //   child: Text(
                    //     'Bank Details',
                    //     style: TextStyle(
                    //       color: kTextBlackColor,
                    //       fontSize: 22,
                    //       fontWeight: FontWeight.w600,
                    //       height: 1.45,
                    //     ),
                    //   ),
                    // ),
                    // kSizedBox,
                    Text(
                      'Bank Name',
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kHalfSizedBox,
                    GetBuilder<WithdrawController>(
                      builder: (controller) {
                        return InkWell(
                          onTap: controller.listOfBanks.isEmpty &&
                                  controller.isLoad.value
                              ? null
                              : selectBank,
                          child: MyBlueTextFormField(
                            controller: bankNameEC,
                            isEnabled: false,
                            textInputAction: TextInputAction.next,
                            focusNode: bankNameFN,
                            hintText: controller.listOfBanks.isEmpty &&
                                    controller.isLoad.value
                                ? "Loading..."
                                : "Select a bank",
                            suffixIcon: FaIcon(
                              FontAwesomeIcons.chevronDown,
                              size: 20,
                              color: kAccentColor,
                            ),
                            textInputType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value!.isEmpty) {
                                return "Select a bank";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              bankNameEC.text = value!;
                            },
                          ),
                        );
                      },
                    ),
                    kSizedBox,
                    Text(
                      'Account Number',
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kHalfSizedBox,
                    MyTextFormField(
                      controller: accountNumberEC,
                      focusNode: accountNumberFN,
                      hintText: "Enter the account number here",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      onChanged: (value) {
                        if (value.length >= 9) {
                          WithdrawController.instance.validateBankNumbers(
                              accountNumberEC.text, bankCode);
                        }
                      },
                      validator: (value) {
                        if (value == null || value!.isEmpty) {
                          accountNumberFN.requestFocus();
                          return "Enter the account number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        accountNumberEC.text = value!;
                      },
                    ),
                    kSizedBox,
                    GetBuilder<WithdrawController>(builder: (controller) {
                      if (controller.isLoad.value) {
                        return Text(
                          'Loading...',
                          style: TextStyle(
                            color: kAccentColor.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                      return Text(
                        controller.validateAccount.value.requestSuccessful
                            ? controller
                                .validateAccount.value.responseBody.accountName
                            : 'Bank details not found',
                        style: TextStyle(
                          color: kAccentColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
