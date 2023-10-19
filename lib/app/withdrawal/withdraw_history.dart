import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:flutter/material.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class WithdrawHistoryPage extends StatefulWidget {
  const WithdrawHistoryPage({Key? key}) : super(key: key);

  @override
  State<WithdrawHistoryPage> createState() => _WithdrawHistoryPageState();
}

class _WithdrawHistoryPageState extends State<WithdrawHistoryPage> {
//===================================== ALL VARIABLES =========================================\\
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    String formattedDateTime = formatDateAndTime(now);

    return Scaffold(
      // backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "Withdrawal History",
        elevation: 0,
        actions: [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Scrollbar(
          controller: _scrollController,
          child: ListView.separated(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => kSizedBox,
            itemCount: 5,
            padding: const EdgeInsets.all(kDefaultPadding),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.shade400,
                      spreadRadius: 2,
                      // offset: Offset(1, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Text(
                            '\u20A6 20,000',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: kAccentColor,
                              fontSize: 16,
                              fontFamily: 'sen',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: mediaWidth - 150,
                          child: Text(
                            formattedDateTime,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: kTextGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    kSizedBox,
                    Text(
                      'Access Bank ...9876',
                      style: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
