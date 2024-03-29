// ignore_for_file: unused_local_variable

import 'package:benji_rider/src/widget/card/empty.dart';
import 'package:benji_rider/src/widget/image/my_image.dart';
import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:benji_rider/src/widget/section/my_liquid_refresh.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../src/providers/constants.dart';
import '../../src/repo/controller/business_controller.dart';
import '../../src/repo/utils/helpers.dart';
import '../../theme/colors.dart';

class Businesses extends StatefulWidget {
  const Businesses({super.key});

  @override
  State<Businesses> createState() => _BusinessesState();
}

class _BusinessesState extends State<Businesses>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // BusinessController.instance.getAllBusinesses();
    checkAuth(context);
    _scrollController.addListener(_scrollListener);
    BusinessController.instance.scrollListener(_scrollController);
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels >= 200 &&
        _isScrollToTopBtnVisible != true) {
      setState(() {
        _isScrollToTopBtnVisible = true;
      });
    }
    if (_scrollController.position.pixels < 200 &&
        _isScrollToTopBtnVisible == true) {
      setState(() {
        _isScrollToTopBtnVisible = false;
      });
    }
  }

  Future<void> _scrollToTop() async {
    await _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _isScrollToTopBtnVisible = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();

    _scrollController.removeListener(() {});
  }

//============================================== ALL VARIABLES =================================================\\

  bool _isScrollToTopBtnVisible = false;

//============================================== CONTROLLERS =================================================\\
  final ScrollController _scrollController = ScrollController();

//============================================== FUNCTIONS =================================================\\

//===================== View Vendor ==========================\\

//===================== Number format ==========================\\
  String formattedText(int value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

//===================== Handle refresh ==========================\\

  Future<void> handleRefresh() async {
    BusinessController.instance.refreshData();
  }

//=============================== See more ========================================\\
  void seeMoreOnlineBusinesses() {}

  @override
  Widget build(BuildContext context) {
    //============================ MediaQuery Size ===============================\\
    var media = MediaQuery.of(context).size;

    return MyLiquidRefresh(
      onRefresh: handleRefresh,
      child: Scaffold(
        appBar: MyAppBar(
          title: "All businesses",
          elevation: 0,
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
          actions: const [],
        ),
        floatingActionButton: _isScrollToTopBtnVisible
            ? FloatingActionButton(
                onPressed: _scrollToTop,
                mini: true,
                foregroundColor: kPrimaryColor,
                backgroundColor: kAccentColor,
                enableFeedback: true,
                mouseCursor: SystemMouseCursors.click,
                tooltip: "Scroll to top",
                hoverColor: kAccentColor,
                hoverElevation: 50.0,
                child: const Icon(Icons.keyboard_arrow_up),
              )
            : const SizedBox(),
        body: GetBuilder<BusinessController>(
          builder: (controller) {
            return SafeArea(
              maintainBottomViewPadding: true,
              child: controller.isLoad.value && controller.businesses.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        color: kAccentColor,
                      ),
                    )
                  : controller.businesses.isEmpty
                      ? const EmptyCard(
                          emptyCardMessage: "There are no businesses",
                        )
                      : Scrollbar(
                          controller: _scrollController,
                          radius: const Radius.circular(10),
                          scrollbarOrientation: ScrollbarOrientation.right,
                          child: ListView(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(kDefaultPadding / 2),
                            children: [
                              ListView.separated(
                                separatorBuilder: (context, index) =>
                                    kHalfSizedBox,
                                itemCount: controller.businesses.length,
                                addAutomaticKeepAlives: true,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        color: kPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x0F000000),
                                            blurRadius: 24,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 130,
                                            height: 130,
                                            decoration: ShapeDecoration(
                                              color: kLightGreyColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                            ),
                                            child: MyImage(
                                              url: controller
                                                  .businesses[index].shopImage,
                                            ),
                                          ),
                                          kHalfWidthSizedBox,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: media.width - 200,
                                                child: Text(
                                                  controller.businesses[index]
                                                      .shopName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    color: kBlackColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: -0.36,
                                                  ),
                                                ),
                                              ),
                                              kHalfSizedBox,
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 1),
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .locationDot,
                                                        color: kAccentColor,
                                                        size: 21,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  SizedBox(
                                                    width: media.width - 200,
                                                    child: Text(
                                                      controller
                                                          .businesses[index]
                                                          .address,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                      style: const TextStyle(
                                                        color: kTextBlackColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              kHalfSizedBox,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // kSizedBox,
                              // TextButton(
                              //   onPressed: seeMoreOnlineBusinesses,
                              //   child: Text(
                              //     "See more",
                              //     style: TextStyle(color: kAccentColor),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}

// Row(
//   children: [
//     Container(
//       width: 3.90,
//       height: 3.90,
//       decoration:
//           ShapeDecoration(
//         color:
//             _vendorActiveColor,
//         shape:
//             const OvalBorder(),
//       ),
//     ),
//     const SizedBox(
//         width: 5.0),
//     Text(
//       _vendorActive,
//       textAlign:
//           TextAlign.center,
//       style: const TextStyle(
//         color: kSuccessColor,
//         fontSize: 14,
//         fontWeight:
//             FontWeight.w400,
//       ),
//     ),
//   ],
// ),
