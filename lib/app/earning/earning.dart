import 'package:flutter/material.dart';

import '../../providers/constants.dart';
import '../../reusable_widgets/drawer.dart';
import '../../theme/colors.dart';

class Earning extends StatelessWidget {
  const Earning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: kDefaultPadding / 2,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
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
              const SizedBox(height: kDefaultPadding),
              const SizedBox(height: kDefaultPadding),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Center(child: Text('Dummy')),
              ),
              const SizedBox(height: kDefaultPadding),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: const Text(
                  'Earning History',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 18,
                    fontFamily: 'Overpass',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 0.25),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      top: kDefaultPadding * 0.5,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 24,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Text(
                                '21 Bartus Street, Abuja Nigeria',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 14,
                                  fontFamily: 'Sen',
                                  fontWeight: FontWeight.w400,
                                  height: 1.40,
                                ),
                                softWrap: true, // Enable text wrapping
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const Text(
                                '#7,000',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFFEC2623),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          child: Text(
                            '23 Feb 2020 • 1:20PM',
                            style: TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: kDefaultPadding,
              )
            ],
          ),
        ),
      ),
    );
  }
}
