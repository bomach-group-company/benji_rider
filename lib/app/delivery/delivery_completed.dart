import 'package:flutter/material.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class DeliverComplete extends StatelessWidget {
  const DeliverComplete({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: kDefaultPadding / 2,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 18),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(10, 10),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: const CircleBorder()),
              onPressed: () {},
              child: Container(
                height: 18,
                width: 18,
                padding: const EdgeInsets.all(2),
                decoration: const ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color(0xFFEC2623),
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEC2623),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          mouseCursor: SystemMouseCursors.click,
          child: Container(
            width: 40,
            height: 40,
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        'assets/images/illustration/walkthrough 1.png',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Delivery complete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFEC2623),
                          fontSize: 23.25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: media.size.width * 0.4,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/food/pasta.png'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: media.size.width * 0.4,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rice and Chicken',
                                  style: TextStyle(
                                    color: Color(0xFF444343),
                                    fontSize: 15.41,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Food ',
                                  style: TextStyle(
                                    color: Color(0xFF444343),
                                    fontSize: 15.41,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '3 plates ',
                                  style: TextStyle(
                                    color: Color(0xFF444343),
                                    fontSize: 15.41,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '40kg ',
                                  style: TextStyle(
                                    color: Color(0xFF444343),
                                    fontSize: 15.41,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Item is fragile (glass) so be careful ',
                                  style: TextStyle(
                                    color: Color(0xFF444343),
                                    fontSize: 15.41,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 18,
                                  width: 18,
                                  padding: const EdgeInsets.all(2),
                                  decoration: const ShapeDecoration(
                                    shape: OvalBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Color(0xFFEC2623),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEC2623),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    color: const Color(0xFFEC2623),
                                    height: 30,
                                    width: 3,
                                  ),
                                ),
                                const Icon(
                                  Icons.location_on_sharp,
                                  color: Color(0xFFEC2623),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pick up 12:05PM',
                                style: TextStyle(
                                  color: Color(0xFF454545),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                'Drop off 12:28PM',
                                style: TextStyle(
                                  color: Color(0xFF454545),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 30,
                thickness: 1,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tue, 23 Feb 2020 12:00PM',
                      style: TextStyle(
                        color: Color(0xFF454545),
                        fontSize: 12.92,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'ID: 2130812309',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF454545),
                        fontSize: 12.92,
                        fontWeight: FontWeight.w400,
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
