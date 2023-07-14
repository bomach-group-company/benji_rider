import 'package:benji_rider/providers/constants.dart';
import 'package:benji_rider/reusable_widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'app/delivered_history/history.dart';

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
  final int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: kDefaultPadding / 2,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const DeliveredHistory();
              },
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.link),
      ),
    );
  }
}
