import 'package:benji_rider/src/widget/section/my_appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class Earning extends StatefulWidget {
  const Earning({super.key});

  @override
  State<Earning> createState() => _EarningState();
}

class _EarningState extends State<Earning> {
//===================================== ALL VARIABLES =========================================\\
  final _scrollController = ScrollController();
  final List<double> barChartList = [3, 5, 8, 9, 7, 3, 5, 2, 7, 8, 9, 8, 4];

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    String formattedDateTime = formatDateAndTime(now);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: kDefaultPadding * 0.5),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 0,
                ),
                height: mediaHeight * 0.6,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
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
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Money Earned',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kTextGreyColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          kHalfSizedBox,
                          Text(
                            '\u20A6 117,500.00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: kAccentColor,
                              fontSize: 22,
                              fontFamily: 'sen',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          kHalfSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                formattedDateTime,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kTextGreyColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          width: barChartList.length.toDouble() * 25,
                          child: BarChart(
                            BarChartData(
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  reservedSize: barChartList
                                      .reduce((value, element) =>
                                          value > element ? value : element)
                                      .toDouble(),
                                  interval: (barChartList.reduce((value,
                                                  element) =>
                                              value > element
                                                  ? value
                                                  : element) ~/
                                          4)
                                      .toDouble(),
                                  showTitles: true,
                                )),
                                topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),

                              gridData: const FlGridData(show: false),
                              borderData: FlBorderData(
                                  show: false,
                                  border: const Border(
                                    top: BorderSide.none,
                                    right: BorderSide.none,
                                    left: BorderSide(width: 1),
                                    bottom: BorderSide(width: 1),
                                  )),
                              groupsSpace: 10,

                              // add bars
                              barGroups: List.generate(
                                      barChartList.length, (index) => index)
                                  .map(
                                    (index) => BarChartGroupData(
                                      x: index + 1,
                                      barRods: [
                                        BarChartRodData(
                                            toY: barChartList[index].toDouble(),
                                            width: 15,
                                            color: kAccentColor),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: const Text(
                  'Earning History',
                  style: TextStyle(
                    color: kTextBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 0.25),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                separatorBuilder: (context, index) => kSizedBox,
                padding: const EdgeInsets.all(kDefaultPadding),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
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
                            SizedBox(
                              width: mediaWidth - 150,
                              child: const Text(
                                '21 Bartus Street, Abuja Nigeria',
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                softWrap: true, // Enable text wrapping
                              ),
                            ),
                            Text(
                              '\u20A6 ${formattedText(7000)}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: kAccentColor,
                                fontSize: 12,
                                fontFamily: 'sen',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: Text(
                            formattedDateTime,
                            style: TextStyle(
                              color: kTextGreyColor,
                              fontSize: 12,
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
