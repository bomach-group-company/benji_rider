import 'package:benji_rider/app/earning/earning.dart';
import 'package:benji_rider/providers/constants.dart';
import 'package:flutter/material.dart';

import '../app/delivered_history/history.dart';
import '../theme/colors.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isOnline = true;

  void toggleOnline() {
    setState(() {
      isOnline = !isOnline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kPrimaryColor,
      elevation: 10.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          top: 25.0,
          right: 15,
          bottom: 25.0,
        ),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 106.67,
                  height: 107.68,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image:
                          AssetImage("assets/images/profile/avatar-image.jpg"),
                      fit: BoxFit.cover,
                    ),
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1.65,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: ShapeDecoration(
                      color: kAccentColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          color: kAccentColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          24,
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: kTextWhiteColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: kDefaultPadding),
              width: MediaQuery.of(context).size.width * 0.4,
              child: const Column(
                children: [
                  Text(
                    'Princewill Okafor',
                    softWrap: true,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 19.86,
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  kHalfSizedBox,
                  Text(
                    'princewillokafor@gmail.com',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 15.44,
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w400,
                      // height: 2,
                    ),
                  )
                ],
              ),
            ),
            kSizedBox,
            kSizedBox,
            kSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Online',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF232323),
                    fontSize: 26.47,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  splashRadius: 5,
                  onPressed: toggleOnline,
                  icon: Icon(
                    isOnline ? Icons.toggle_on : Icons.toggle_off,
                    size: 35,
                  ),
                ),
              ],
            ),
            kSizedBox,
            const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              leading: Icon(
                Icons.home_outlined,
                size: 24,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 19.86,
                  fontFamily: 'Sen',
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const Earning();
                    },
                  ),
                );
              },
              child: const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                leading: Icon(
                  Icons.money,
                  size: 24,
                ),
                title: Text(
                  'Earnings',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 19.86,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const DeliveredHistory();
                    },
                  ),
                );
              },
              child: const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                leading: Icon(
                  Icons.location_on_outlined,
                  size: 24,
                ),
                title: Text(
                  'Delivery History',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 19.86,
                    fontFamily: 'Sen',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              leading: Icon(
                Icons.question_mark_outlined,
                size: 24,
              ),
              title: Text(
                'Help & Support',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 19.86,
                  fontFamily: 'Sen',
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              leading: Icon(
                Icons.settings,
                size: 24,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 19.86,
                  fontFamily: 'Sen',
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              leading: Icon(
                Icons.logout,
                size: 24,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 19.86,
                  fontFamily: 'Sen',
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
