import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class DeliveredHistory extends StatefulWidget {
  const DeliveredHistory({super.key});

  @override
  State<DeliveredHistory> createState() => _DeliveredHistoryState();
}

class _DeliveredHistoryState extends State<DeliveredHistory> {
  bool onDelivered = true;
  bool isLoading = false;

  void clickDelivered() async {
    setState(() {
      isLoading = true;
      onDelivered = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  void clickCancelled() async {
    setState(() {
      isLoading = true;
      onDelivered = false;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            GestureDetector(
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
            const SizedBox(
              width: 35,
            ),
            const Text(
              'History',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
      body: isLoading
          ? SpinKitChasingDots(
              color: kAccentColor,
              size: 30,
            )
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: kDefaultPadding,
                    ),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: onDelivered
                                ? kAccentColor
                                : const Color(0xFFF2F2F2),
                            padding: const EdgeInsets.all(18),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                          ),
                          onPressed: clickDelivered,
                          child: Text(
                            'Delivered',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  onDelivered ? kTextWhiteColor : kGreyColor2,
                              fontSize: 14,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: onDelivered
                                ? const Color(0xFFF2F2F2)
                                : kAccentColor,
                            padding: const EdgeInsets.all(18),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                          onPressed: clickCancelled,
                          child: Text(
                            'Cancelled',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  onDelivered ? kGreyColor2 : kTextWhiteColor,
                              fontSize: 14,
                              fontFamily: 'Sen',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: kDefaultPadding,
                                right: kDefaultPadding,
                                top: kDefaultPadding * 0.5,
                              ),
                              decoration: ShapeDecoration(
                                color: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0F000000),
                                    blurRadius: 24,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      // height: h * 0.17,
                                      child: Container(
                                        // width: 110,
                                        height: 119,
                                        decoration: const ShapeDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/food/burgers.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 7,
                                        horizontal: 12,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'ID 213081',
                                                style: TextStyle(
                                                  color: onDelivered
                                                      ? const Color(0xFF454545)
                                                      : const Color(0xFF979797),
                                                  fontSize: 12,
                                                  fontFamily: 'Sen',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Container(
                                                // width: 68,
                                                // height: 24,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7,
                                                        vertical: 5),
                                                decoration: ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                      width: 0.50,
                                                      color: Color(0xFFC8C8C8),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  width: 54,
                                                  height: 10,
                                                  child: Text(
                                                    onDelivered
                                                        ? 'Delivered'
                                                        : 'Cancelled',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: onDelivered
                                                          ? kAccentColor
                                                          : const Color(
                                                              0xFF979797),
                                                      fontSize: 10,
                                                      fontFamily: 'Overpass',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            'Food',
                                            style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 12,
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 12,
                                                    width: 12,
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    decoration: ShapeDecoration(
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                          width: 1,
                                                          color: kAccentColor,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: kAccentColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    color: kAccentColor,
                                                    height: 10,
                                                    width: 1.5,
                                                  ),
                                                  Icon(
                                                    Icons.location_on_sharp,
                                                    size: 12,
                                                    color: kAccentColor,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '21 Bartus Street, Abuja Nigeria',
                                                    style: TextStyle(
                                                      color: onDelivered
                                                          ? const Color(
                                                              0xFF454545)
                                                          : const Color(
                                                              0xFF979797),
                                                      fontSize: 10,
                                                      fontFamily: 'Mulish',
                                                      height: 2,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    '3 Edwins Close, Wuse, Abuja',
                                                    style: TextStyle(
                                                      color: onDelivered
                                                          ? const Color(
                                                              0xFF454545)
                                                          : const Color(
                                                              0xFF979797),
                                                      fontSize: 10,
                                                      fontFamily: 'Mulish',
                                                      height: 2,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 22,
                                                    ),
                                                    Text(
                                                      '24-02 2022 12:00PM',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF929292),
                                                        fontSize: 10,
                                                        fontFamily: 'Overpass',
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  'NGN 5,000',
                                                  style: TextStyle(
                                                    color: onDelivered
                                                        ? const Color(
                                                            0xFF454545)
                                                        : const Color(
                                                            0xFF979797),
                                                    fontSize: 10,
                                                    fontFamily: 'Overpass',
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
