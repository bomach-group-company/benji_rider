import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:benji_rider/src/widget/section/my_floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/button/my_elevatedbutton.dart';
import '../../src/widget/form_and_auth/my textformfield.dart';
import '../../theme/colors.dart';

class AddBankAccountPage extends StatefulWidget {
  const AddBankAccountPage({Key? key}) : super(key: key);

  @override
  State<AddBankAccountPage> createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
//===================================== ALL VARIABLES =========================================\\
  FocusNode productType = FocusNode();
  FocusNode _accountNumberFN = FocusNode();
  TextEditingController _accountNumberEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String dropDownItemValue = "Access Bank";
  bool _savingAccount = false;

  //================================== FUNCTION ====================================\\

  void dropDownOnChanged(String? onChanged) {
    setState(() {
      dropDownItemValue = onChanged!;
    });
  }

  Future<void> _saveAccount() async {
    setState(() {
      _savingAccount = true;
    });

    await Future.delayed(Duration(seconds: 2));

    mySnackBar(
      context,
      kSuccessColor,
      "Success",
      "You account has been saved successfully",
      Duration(milliseconds: 500),
    );

    await Future.delayed(Duration(milliseconds: 800));

    setState(() {
      _savingAccount = false;
    });
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
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(kDefaultPadding),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank Details',
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    kSizedBox,
                    kSizedBox,
                    Text(
                      'Bank Name',
                      style: TextStyle(
                        color: kTextGreyColor,
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
                          return "Pick a  bank";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.blue.shade50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.blue.shade50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.blue.shade50),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: kErrorBorderColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(16),
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
                                'assets/icons/accessbank.png',
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
                                'assets/icons/accessbank.png',
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
                                'assets/icons/accessbank.png',
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
                                'assets/icons/accessbank.png',
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
                      'Account Number',
                      style: TextStyle(
                        color: kTextGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    kHalfSizedBox,
                    MyTextFormField(
                      controller: _accountNumberEC,
                      focusNode: _accountNumberFN,
                      hintText: "Enter the account number here",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        RegExp _accountNumberPattern = RegExp(r"^\d{10}$");
                        if (value == null || value!.isEmpty) {
                          _accountNumberFN.requestFocus();
                          return "Enter the account number";
                        } else if (!_accountNumberPattern.hasMatch(value)) {
                          _accountNumberFN.requestFocus();
                          return "Number must be 10 characters";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _accountNumberEC.text = value!;
                      },
                    ),
                    kSizedBox,
                    Text(
                      'Blessing Mesoma',
                      style: TextStyle(
                        color: kAccentColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding * 2,
                    ),
                    _savingAccount
                        ? CircularProgressIndicator(color: kAccentColor)
                        : MyElevatedButton(
                            onPressed: (() async {
                              if (_formKey.currentState!.validate()) {
                                await _saveAccount();
                              }
                            }),
                            title: "Save Account",
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
