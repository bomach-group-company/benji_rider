// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/form_and_auth/otp_textFormField.dart';
import '../../src/widget/form_and_auth/reusable_authentication_first_half.dart';
import '../../src/widget/section/my_appbar.dart';
import '../../src/widget/section/my_fixed_snackBar.dart';
import '../../theme/colors.dart';
import '../../theme/responsive_constant.dart';
import 'reset_password.dart';

class SendOTP extends StatefulWidget {
  const SendOTP({super.key});

  @override
  State<SendOTP> createState() => _SendOTPState();
}

class _SendOTPState extends State<SendOTP> {
  //=========================== INITIAL STATE ====================================\\
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //=========================== ALL VARIABBLES ====================================\\
  late Timer _timer;
  int _secondsRemaining = 60;
  //=========================== Bool ====================================\\

  bool _timerComplete = false;

  //=========================== CONTROLLERS ====================================\\

  TextEditingController pin1EC = TextEditingController();
  TextEditingController pin2EC = TextEditingController();
  TextEditingController pin3EC = TextEditingController();
  TextEditingController pin4EC = TextEditingController();

  //=========================== KEYS ====================================\\

  final _formKey = GlobalKey<FormState>();

  //=========================== FOCUS NODES ====================================\\
  FocusNode pin1FN = FocusNode();
  FocusNode pin2FN = FocusNode();
  FocusNode pin3FN = FocusNode();
  FocusNode pin4FN = FocusNode();

  //=========================== BOOL VALUES====================================\\
  bool isLoading = false;

  //=========================== FUNCTIONS ====================================\\

  //================= Start Timer ======================\\
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _timerComplete = true;
        });
        _timer.cancel();
      }
    });
  }

  //================= Resend OTP ======================\\
  void _resendOTP() {
    // Implement your resend OTP logic here
    // For example, you could restart the timer and reset the `_timerComplete` state.
    setState(() {
      _secondsRemaining = 60;
      _timerComplete = false;
      startTimer();
    });
  }

  String formatTime(int seconds) {
    int _minutes = seconds ~/ 60;
    int _remainingSeconds = seconds % 60;
    String _minutesStr = _minutes.toString().padLeft(2, '0');
    String _secondsStr = _remainingSeconds.toString().padLeft(2, '0');
    return '$_minutesStr:$_secondsStr';
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(const Duration(seconds: 2));

    //Display snackBar
    myFixedSnackBar(
      context,
      "OTP Verified".toUpperCase(),
      kSuccessColor,
      const Duration(
        seconds: 2,
      ),
    );

    // Navigate to the new page
    Get.to(
      () => const ResetPassword(),
      routeName: 'ResetPassword',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: MyAppBar(
          title: "",
          elevation: 0.0,
          actions: [],
          backgroundColor: kTransparentColor,
          toolbarHeight: kToolbarHeight,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: LayoutGrid(
            columnSizes: breakPointDynamic(
                media.size.width, [1.fr], [1.fr], [1.fr, 1.fr], [1.fr, 1.fr]),
            rowSizes: [auto, 1.fr],
            children: [
              Column(
                children: [
                  Expanded(
                    child: ReusableAuthenticationFirstHalf(
                      title: "Verification",
                      subtitle: "We have sent a code to your email",
                      curves: Curves.easeInOut,
                      duration: Duration(),
                      containerChild: Icon(
                        Icons.login,
                        color: kBlackColor,
                      ),
                      decoration: const ShapeDecoration(
                          // color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/logo/benji_red_logo_icon.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: OvalBorder()),
                      imageContainerHeight:
                          deviceType(media.size.width) > 2 ? 200 : 88,
                    ),
                  ),
                ],
              ),
              Container(
                height: media.size.height,
                width: media.size.width,
                padding: const EdgeInsets.only(
                  top: kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        breakPoint(media.size.width, 24, 24, 0, 0)),
                    topRight: Radius.circular(
                        breakPoint(media.size.width, 24, 24, 0, 0)),
                  ),
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      width: media.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedDefaultTextStyle(
                            child: Text('Code'.toUpperCase()),
                            duration: Duration(milliseconds: 300),
                            style: TextStyle(
                              color: _timerComplete
                                  ? kAccentColor
                                  : kTextGreyColor,
                              fontSize: 15,
                              fontWeight: _timerComplete
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: _timerComplete ? _resendOTP : null,
                                child: AnimatedDefaultTextStyle(
                                  child: Text("Resend"),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: _timerComplete
                                        ? kAccentColor
                                        : kTextGreyColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                ),
                              ),
                              const Text(
                                "in ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: kTextBlackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                formatTime(_secondsRemaining),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: kTextBlackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    kSizedBox,
                    Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 90,
                            width: 68,
                            child: MyOTPTextFormField(
                              textInputAction: TextInputAction.next,
                              onSaved: (pin1) {
                                pin1EC.text = pin1!;
                              },
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  pin1FN.requestFocus();
                                  return "";
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 90,
                            width: 68,
                            child: MyOTPTextFormField(
                              textInputAction: TextInputAction.next,
                              onSaved: (pin2) {
                                pin2EC.text = pin2!;
                              },
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  pin2FN.requestFocus();
                                  return "";
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 90,
                            width: 70,
                            child: MyOTPTextFormField(
                              textInputAction: TextInputAction.next,
                              onSaved: (pin3) {
                                pin3EC.text = pin3!;
                              },
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  pin3FN.requestFocus();
                                  return "";
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 90,
                            width: 68,
                            child: MyOTPTextFormField(
                              textInputAction: TextInputAction.done,
                              onSaved: (pin4) {
                                pin4EC.text = pin4!;
                              },
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nearestScope;
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  pin4FN.requestFocus();
                                  return "";
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultPadding * 2,
                    ),
                    isLoading
                        ? Center(
                            child: SpinKitChasingDots(
                              color: kAccentColor,
                              duration: const Duration(seconds: 2),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: (() async {
                              if (_formKey.currentState!.validate()) {
                                loadData();
                              }
                            }),
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: kAccentColor,
                              fixedSize: Size(media.size.width, 50),
                            ),
                            child: Text(
                              'Verify'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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
