import 'package:benji_rider/repo/controller/api_url.dart';
import 'package:benji_rider/repo/controller/form_controller.dart';
import 'package:benji_rider/repo/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/providers/constants.dart';
import '../../src/widget/button/my_elevatedbutton.dart';
import '../../src/widget/form_and_auth/message_textformfield.dart';
import '../../src/widget/section/my_appbar.dart';
import '../../theme/colors.dart';

class HelpNSupport extends StatefulWidget {
  const HelpNSupport({super.key});

  @override
  State<HelpNSupport> createState() => _HelpNSupportState();
}

class _HelpNSupportState extends State<HelpNSupport> {
  //============================================ ALL VARIABLES ===========================================\\
  //============================================ CONTROLLERS ===========================================\\
  final TextEditingController _messageEC = TextEditingController();

  //============================================ FOCUS NODES ===========================================\\
  final FocusNode _messageFN = FocusNode();

  //============================================ KEYS ===========================================\\
  final GlobalKey<FormState> _formKey = GlobalKey();

  //============================================ FUNCTIONS ===========================================\\
  //========================== Save data ==================================\\
  Future<void> _submitRequest() async {
    Map data = {
      "user_id": UserController.instance.user.value.id,
      "message": _messageEC.text,
    };

    print(data);
    print(Api.baseUrl + Api.createSupport);

    await FormController.instance
        .postAuth(Api.baseUrl + Api.createSupport, data, 'createSupport');
    if (FormController.instance.status.value.toString().startsWith('2')) {
      Get.close(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        title: "Help and support",
        elevation: 10.0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      bottomNavigationBar: Container(
        color: kPrimaryColor,
        padding: const EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding,
        ),
        child: GetBuilder<FormController>(
          id: 'createSupport',
          builder: (controller) => MyElevatedButton(
            isLoading: controller.isLoad.value,
            onPressed: (() async {
              if (_formKey.currentState!.validate()) {
                _submitRequest();
              }
            }),
            title: "Submit",
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(kDefaultPadding),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              width: 292,
              child: Text(
                'We will like to hear from you',
                style: TextStyle(
                  color: kTextBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            kHalfSizedBox,
            SizedBox(
              width: 332,
              child: Text(
                '',
                style: TextStyle(
                  color: kTextGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyMessageTextFormField(
                    controller: _messageEC,
                    validator: (value) {
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    focusNode: _messageFN,
                    hintText: "Enter your message here",
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    maxLength: 6000,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
