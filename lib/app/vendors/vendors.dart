// ignore_for_file: unused_local_variable

import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../src/providers/constants.dart';
import '../../src/providers/custom_show_search.dart';
import '../../src/widget/skeletons/all_vendors_page_skeleton.dart';
import '../../src/widget/skeletons/vendors_list_skeleton.dart';
import '../../theme/colors.dart';

class Vendors extends StatefulWidget {
  const Vendors({
    super.key,
  });

  @override
  State<Vendors> createState() => _VendorsState();
}

class _VendorsState extends State<Vendors> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scrollController.addListener(_scrollListener);

    _loadingScreen = true;
    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(
        () => _loadingScreen = false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _scrollController.dispose();

    _scrollController.removeListener(() {});
  }

//============================================== ALL VARIABLES =================================================\\
  late bool _loadingScreen;
  bool _isLoadingVendorStatus = false;
  bool _isScrollToTopBtnVisible = false;

  //Online Vendors
  final String _vendorsName = "Ntachi Osa";
  final String _vendorsImage = "ntachi-osa";
  final String _vendorsLocation =
      "Achara layout, Enugu Abokki bustop by tunnel road abia bustop by tunnel road abia";
  final int _vendors = 15;

  // final String _vendorActive = "Online";
  // final Color _vendorActiveColor = kSuccessColor;
  final int _totalNumberOfOrders = 20000;

//============================================== CONTROLLERS =================================================\\
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

//============================================== FUNCTIONS =================================================\\

//===================== View Vendor ==========================\\
  void _viewVendor() {}

//===================== Number format ==========================\\
  String formattedText(int value) {
    final numberFormat = NumberFormat('#,##0');
    return numberFormat.format(value);
  }

//===================== Handle refresh ==========================\\

  Future<void> _handleRefresh() async {
    setState(() {
      _loadingScreen = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _loadingScreen = false;
    });
  }

//============================= Scroll to Top ======================================//
  void _scrollToTop() {
    _animationController.reverse();
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollListener() {
    //========= Show action button ========//
    if (_scrollController.position.pixels >= 200) {
      _animationController.forward();
      setState(() => _isScrollToTopBtnVisible = true);
    }
    //========= Hide action button ========//
    else if (_scrollController.position.pixels < 200) {
      _animationController.reverse();
      setState(() => _isScrollToTopBtnVisible = true);
    }
  }

//=============================== See more ========================================\\
  void _seeMoreOnlineVendors() {}

  void _showSearchField() =>
      showSearch(context: context, delegate: CustomSearchDelegate());
  @override
  Widget build(BuildContext context) {
    //============================ MediaQuery Size ===============================\\
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      color: kAccentColor,
      borderWidth: 5.0,
      backgroundColor: kPrimaryColor,
      height: 150,
      animSpeedFactor: 2,
      showChildOpacityTransition: false,
      child: Scaffold(
        appBar: MyAppBar(
          title: "All vendors",
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
          actions: [
            IconButton(
              onPressed: _showSearchField,
              tooltip: "Search for a vendor",
              icon: Icon(
                Icons.search_rounded,
                color: kAccentColor,
                size: 24,
              ),
            ),
          ],
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            if (_isScrollToTopBtnVisible) ...[
              ScaleTransition(
                scale: CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
                child: FloatingActionButton(
                  onPressed: _scrollToTop,
                  mini: true,
                  backgroundColor: kAccentColor,
                  enableFeedback: true,
                  mouseCursor: SystemMouseCursors.click,
                  tooltip: "Scroll to top",
                  hoverColor: kAccentColor,
                  hoverElevation: 50.0,
                  child: const Icon(Icons.keyboard_arrow_up),
                ),
              ),
            ]
          ],
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: FutureBuilder(builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const AllVendorsPageSkeleton();
            }
            if (snapshot.connectionState == ConnectionState.none) {
              const Center(
                child: Text("Please connect to the internet"),
              );
            }
            // if (snapshot.connectionState == snapshot.requireData) {
            //   SpinKitDoubleBounce(color: kAccentColor);
            // }
            if (snapshot.connectionState == snapshot.error) {
              const Center(
                child: Text("Error, Please try again later"),
              );
            }
            return _loadingScreen
                ? const AllVendorsPageSkeleton()
                : Scrollbar(
                    controller: _scrollController,
                    radius: const Radius.circular(10),
                    scrollbarOrientation: ScrollbarOrientation.right,
                    child: ListView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      children: [
                        _isLoadingVendorStatus
                            ? const VendorsListSkeleton()
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: kDefaultPadding / 2),
                                itemCount: _vendors,
                                addAutomaticKeepAlives: true,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: _viewVendor,
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
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
                                            color: kPageSkeletonColor,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                "assets/images/vendors/$_vendorsImage.png",
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                        ),
                                        kHalfWidthSizedBox,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: mediaWidth - 200,
                                              child: Text(
                                                _vendorsName,
                                                overflow: TextOverflow.ellipsis,
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
                                                  onTap: _viewVendor,
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.only(top: 1),
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .locationDot,
                                                      color: kAccentColor,
                                                      size: 21,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                SizedBox(
                                                  width: mediaWidth - 200,
                                                  child: Text(
                                                    "$_vendorsLocation",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    style: TextStyle(
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
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.boxOpen,
                                                  size: 15,
                                                  color: kAccentColor,
                                                ),
                                                SizedBox(width: 5),
                                                SizedBox(
                                                  width: mediaWidth - 200,
                                                  child: Text(
                                                    "${formattedText(_totalNumberOfOrders)} orders",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: kTextBlackColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: -0.24,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        kSizedBox,
                        TextButton(
                          onPressed: _seeMoreOnlineVendors,
                          child: Text(
                            "See more",
                            style: TextStyle(color: kAccentColor),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
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