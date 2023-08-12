import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/button/my_elevatedbutton.dart';
import '../../src/widget/form_and_auth/my textformfield.dart';
import '../../src/widget/responsive/reponsive_width.dart';
import '../../theme/colors.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
//===================================== ALL VARIABLES =========================================\\
  FocusNode productType = FocusNode();
  FocusNode productNameFN = FocusNode();
  TextEditingController productNameEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String dropDownItemValue = "Access Bank";

  //================================== FUNCTION ====================================\\

  void dropDownOnChanged(String? onChanged) {
    setState(() {
      dropDownItemValue = onChanged!;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = formatDateAndTime(now);
    final media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: -20,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Builder(
            builder: (context) => Row(
              children: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: kAccentColor,
                  ),
                ),
                kHalfWidthSizedBox,
                Text(
                  "Withdraw",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kBlackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: MyResponsiveWidth(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Bank',
                    style: TextStyle(
                      color: Color(0xFF575757),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  kHalfSizedBox,
                  DropdownButtonFormField<String>(
                    value: dropDownItemValue,
                    onChanged: dropDownOnChanged,
                    enableFeedback: true,
                    focusNode: productType,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    elevation: 20,
                    validator: (value) {
                      if (value == null) {
                        productType.requestFocus();
                        return "Pick a Product Type";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide(
                          color: Colors.blue.shade50,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide(
                          color: Colors.blue.shade50,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide(
                          color: Colors.blue.shade50,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: const BorderSide(
                          color: kErrorBorderColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    iconEnabledColor: kAccentColor,
                    iconDisabledColor: kGreyColor2,
                    items: [
                      DropdownMenuItem<String>(
                        value: "Access Bank",
                        enabled: true,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icons/accessbank.png',
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              'Access Bank',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "UBA",
                        enabled: true,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icons/accessbank.png',
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              'UBA',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "FCMB",
                        enabled: true,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icons/accessbank.png',
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              'FCMB',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "First Bank",
                        enabled: true,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icons/accessbank.png',
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              'First Bank',
                              style: TextStyle(
                                color: kTextBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  Text(
                    'Amount',
                    style: TextStyle(
                      color: Color(0xFF575757),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  kHalfSizedBox,
                  MyTextFormField(
                    controller: productNameEC,
                    focusNode: productNameFN,
                    hintText: "Enter the product name here",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value!.isEmpty) {
                        productNameFN.requestFocus();
                        return "Enter the product name";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      productNameEC.text = value!;
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding * 4,
                  ),
                  MyElevatedButton(
                    onPressed: () {},
                    title: "Withdraw",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
