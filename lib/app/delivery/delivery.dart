import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/responsive/reponsive_width.dart';
import '../../src/widget/responsive/responsive_width_appbar.dart';
import '../../theme/colors.dart';

enum StatusType { delivered, pending, cancelled }

class Delivery extends StatefulWidget {
  final StatusType status;
  const Delivery({super.key, this.status = StatusType.delivered});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  StatusType? _status;
  bool isLoading = false;

  final _scrollController = ScrollController();

  @override
  void initState() {
    _status = widget.status;
    super.initState();
  }

  void clickDelivered() async {
    setState(() {
      isLoading = true;
      _status = StatusType.delivered;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  void clickPending() async {
    setState(() {
      isLoading = true;
      _status = StatusType.pending;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  void clickCancelled() async {
    setState(() {
      isLoading = true;
      _status = StatusType.cancelled;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  bool checkStatus(StatusType? theStatus, StatusType currentStatus) =>
      theStatus == currentStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyResponsiveWidthAppbar(
        child: MyAppBar(
          title: "Delivery",
          elevation: 0.0,
          actions: const [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: kAccentColor,
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  MyResponsiveWidth(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 24,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      padding: const EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding * 0.6,
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    checkStatus(_status, StatusType.delivered)
                                        ? kAccentColor
                                        : const Color(0xFFF2F2F2),
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
                                      checkStatus(_status, StatusType.delivered)
                                          ? kTextWhiteColor
                                          : kGreyColor2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    checkStatus(_status, StatusType.pending)
                                        ? kAccentColor
                                        : const Color(0xFFF2F2F2),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                              ),
                              onPressed: clickPending,
                              child: Text(
                                'Pending',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      checkStatus(_status, StatusType.pending)
                                          ? kTextWhiteColor
                                          : kGreyColor2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    checkStatus(_status, StatusType.cancelled)
                                        ? kAccentColor
                                        : kDefaultCategoryBackgroundColor,
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
                                      checkStatus(_status, StatusType.cancelled)
                                          ? kTextWhiteColor
                                          : kGreyColor2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.separated(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(kDefaultPadding),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: kDefaultPadding / 2),
                        itemBuilder: (BuildContext context, int index) {
                          return MyResponsiveWidth(
                            child: Column(
                              children: [
                                Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'ID 213081',
                                                    style: TextStyle(
                                                      color: !checkStatus(
                                                              _status,
                                                              StatusType
                                                                  .cancelled)
                                                          ? const Color(
                                                              0xFF454545)
                                                          : const Color(
                                                              0xFF979797),
                                                      fontSize: 12,
                                                      fontFamily: 'Sen',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Container(
                                                    // width: 68,
                                                    // height: 24,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 7,
                                                        vertical: 5),
                                                    decoration: ShapeDecoration(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                          width: 0.50,
                                                          color:
                                                              Color(0xFFC8C8C8),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      checkStatus(
                                                              _status,
                                                              StatusType
                                                                  .delivered)
                                                          ? 'Delivered'
                                                          : checkStatus(
                                                                  _status,
                                                                  StatusType
                                                                      .pending)
                                                              ? 'Pending'
                                                              : 'Cancelled',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: checkStatus(
                                                                _status,
                                                                StatusType
                                                                    .delivered)
                                                            ? kAccentColor
                                                            : checkStatus(
                                                                    _status,
                                                                    StatusType
                                                                        .pending)
                                                                ? kLoadingColor
                                                                : const Color(
                                                                    0xFF979797),
                                                        fontSize: 10,
                                                        fontFamily: 'Overpass',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                'Food',
                                                style: TextStyle(
                                                  color: kTextGreyColor,
                                                  fontSize: 12,
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
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 12,
                                                        width: 12,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        decoration:
                                                            ShapeDecoration(
                                                          shape: OvalBorder(
                                                            side: BorderSide(
                                                              width: 1,
                                                              color:
                                                                  kAccentColor,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: kAccentColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
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
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '21 Bartus Street, Abuja Nigeria',
                                                          style: TextStyle(
                                                            color: !checkStatus(
                                                                    _status,
                                                                    StatusType
                                                                        .cancelled)
                                                                ? const Color(
                                                                    0xFF454545)
                                                                : const Color(
                                                                    0xFF979797),
                                                            fontSize: 10,
                                                            height: 2,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          '3 Edwins Close, Wuse, Abuja',
                                                          style: TextStyle(
                                                            color: !checkStatus(
                                                                    _status,
                                                                    StatusType
                                                                        .cancelled)
                                                                ? const Color(
                                                                    0xFF454545)
                                                                : const Color(
                                                                    0xFF979797),
                                                            fontSize: 10,
                                                            height: 2,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 22,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    child: Text(
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
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      '\u20A6 65,000',
                                                      style: TextStyle(
                                                        color: !checkStatus(
                                                                _status,
                                                                StatusType
                                                                    .cancelled)
                                                            ? const Color(
                                                                0xFF454545)
                                                            : const Color(
                                                                0xFF979797),
                                                        fontSize: 10,
                                                        fontFamily: 'sen',
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
