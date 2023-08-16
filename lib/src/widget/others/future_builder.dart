import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../theme/colors.dart';

class MyFutureBuilder extends StatelessWidget {
  final dynamic future;
  final Widget child;
  const MyFutureBuilder({super.key, required this.future, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return child;
        }
        return Center(
          child: SpinKitChasingDots(color: kAccentColor),
        );
      },
    );
  }
}
