import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';

import '../../src/widget/section/select_bank_body.dart';

class SelectBank extends StatelessWidget {
  const SelectBank({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        appBar: MyAppBar(
          title: "Select a bank",
          elevation: 0,
          actions: const [],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SelectBankBody(),
      ),
    );
  }
}
