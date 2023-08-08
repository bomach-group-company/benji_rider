// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/form_and_auth/email textformfield.dart';
import '../../src/widget/form_and_auth/reusable authentication first half.dart';
import '../../src/widget/section/my fixed snackBar.dart';
import '../../theme/colors.dart';
import '../../theme/responsive_constant.dart';
import 'otp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //=========================== ALL VARIABBLES ====================================\\

  //=========================== CONTROLLERS ====================================\\

  TextEditingController emailController = TextEditingController();

  //=========================== KEYS ====================================\\

  final _formKey = GlobalKey<FormState>();

  //=========================== FOCUS NODES ====================================\\
  FocusNode emailFocusNode = FocusNode();

  //=========================== BOOL VALUES====================================\\
  bool isLoading = false;

  //=========================== FUNCTIONS ====================================\\
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    // Simulating a delay of 3 seconds
    await Future.delayed(const Duration(seconds: 2));

    //Display snackBar
    myFixedSnackBar(
      context,
      "An OTP code has been sent to your email".toUpperCase(),
      kSecondaryColor,
      const Duration(
        seconds: 2,
      ),
    );

    // Navigate to the new page
    Get.to(
      const SendOTP(),
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
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: LayoutGrid(
            columnSizes: breakPointDynamic(
                media.size.width, [1.fr], [1.fr], [1.fr, 1.fr], [1.fr, 1.fr]),
            rowSizes: [auto, 1.fr],
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          Navigator.of(context).pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: ShapeDecoration(
                                      color: const Color(
                                        0xFFFEF8F8,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 0.50,
                                          color: Color(
                                            0xFFFDEDED,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          24,
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: kAccentColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ReusableAuthenticationFirstHalf(
                      title: "Forgot Password",
                      subtitle:
                          "Forgot your password? Enter your email below and we will send you a code via which you need to recover your password",
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/login/avatar-image.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                        shape: CircleBorder(),
                      ),
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
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            child: Text(
                              'Email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(
                                  0xFF31343D,
                                ),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          EmailTextFormField(
                            controller: emailController,
                            emailFocusNode: emailFocusNode,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              RegExp emailPattern = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                              );
                              if (value == null || value!.isEmpty) {
                                emailFocusNode.requestFocus();
                                return "Enter your email address";
                              } else if (!emailPattern.hasMatch(value)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              emailController.text = value;
                            },
                          ),
                          const SizedBox(
                            height: 30,
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: kAccentColor,
                                    fixedSize: Size(media.size.width, 50),
                                  ),
                                  child: Text(
                                    'Send Code'.toUpperCase(),
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
            ],
          ),
        ),
      ),
    );
  }
}