import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/form_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/button/my_elevatedbutton.dart';
import '../../src/widget/form_and_auth/number_textformfield.dart';
import '../../src/widget/responsive/reponsive_width.dart';
import '../../src/widget/section/my_appbar.dart';
import '../../theme/colors.dart';

class WithdrawPage extends StatefulWidget {
  final String bankDetailId;
  const WithdrawPage({super.key, required this.bankDetailId});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  @override
  void initState() {
    super.initState();
    // Add a listener to format the input with commas
    amountEC.addListener(() {
      final text = amountEC.text;
      final cleanText =
          text.replaceAll(RegExp(r'[^\d]'), ''); // Remove non-digits
      final formattedText = NumberFormat('#,###').format(int.parse(cleanText));

      if (text != formattedText) {
        amountEC.value = amountEC.value.copyWith(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }
    });
  }

//===================================== ALL VARIABLES =========================================\\
  final productType = FocusNode();
  final amountFN = FocusNode();
  final amountEC = TextEditingController();
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();

  //================================== FUNCTION ====================================\\
  void makeWithdrawal() async {
    Map data = {
      "user_id": UserController.instance.user.value.id,
      "amount_to_withdraw": amountEC.text,
      "bank_details_id": widget.bankDetailId
    };
    print(data);

    await FormController.instance.postAuth(
        '${Api.baseUrl}/wallet/requestRiderWithdrawal',
        data,
        'requestRiderWithdrawal',
        "Error occurred",
        "Withdrawal Successful");
    if (FormController.instance.status.value.toString().startsWith('2')) {
      Get.close(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "Withdraw",
          elevation: 0,
          actions: const [],
          backgroundColor: kPrimaryColor,
        ),
        body: SafeArea(
          child: MyResponsiveWidth(
            child: Scrollbar(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(10),
                physics: const BouncingScrollPhysics(),
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: kDefaultPadding),
                          child: Text(
                            'Amount',
                            style: TextStyle(
                              color: kTextGreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        kHalfSizedBox,
                        NumberTextFormField(
                          controller: amountEC,
                          focusNode: amountFN,
                          hintText: "Enter the amount here",
                          textInputAction: TextInputAction.go,
                          validator: (value) {
                            if (value == null || value!.isEmpty) {
                              amountFN.requestFocus();
                              return "Enter the amount";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            amountEC.text = value!;
                          },
                        ),
                        kSizedBox,
                        MyElevatedButton(
                          onPressed: (() async {
                            if (formKey.currentState!.validate()) {
                              makeWithdrawal();
                            }
                          }),
                          title: "Withdraw",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
