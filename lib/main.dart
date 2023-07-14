import 'package:benji_rider/providers/constants.dart';
import 'package:benji_rider/reusable_widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Benji Rider',
      home: MyHomePage(
        title: 'Benji',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        titleSpacing: kDefaultPadding / 2,
        title: Builder(
          builder: (context) => IconButton(
            splashRadius: 20,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Image.asset(
              "assets/images/icons/drawer-icon.png",
            ),
          ),
        ),
      ),
      body: const Center(),
    );
  }
}
