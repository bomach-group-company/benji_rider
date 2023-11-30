// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class MyElevatedOvalButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final bool isLoading;

  const MyElevatedOvalButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: kAccentColor.withOpacity(0.5),
        backgroundColor: kAccentColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: kTextWhiteColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
