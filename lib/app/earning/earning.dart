import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import '../../src/widget/responsive/reponsive_width.dart';
import '../../theme/colors.dart';

class Earning extends StatefulWidget {
  const Earning({Key? key}) : super(key: key);

  @override
  State<Earning> createState() => _EarningState();
}

class _EarningState extends State<Earning> {
//===================================== ALL VARIABLES =========================================\\
  final List<double> barChartList = [
    3,
    5,
    8,
    9,
    7,
    3,
    5,
    2,
    7,
    8,
    9,
    8,
    4,
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = formatDateAndTime(now);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: kDefaultPadding / 2,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: InkWell(
          onTap: () {
            Get.back();
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
          child: MyResponsiveWidth(
            child: Column(
              children: [
                const SizedBox(height: kDefaultPadding * 0.5),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 0,
                  ),
                  height: MediaQuery.of(context).size.height * 0.6,
                  // width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                      Container(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Money Earned',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF979797),
                                fontSize: 15,
                                fontFamily: 'Overpass',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            kHalfSizedBox,
                            Text(
                              '#117,500.00',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFFEC2623),
                                fontSize: 22,
                                fontFamily: 'Sen',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kHalfSizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '15 Feb - 21 Feb',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF979797),
                                    fontSize: 13,
                                    fontFamily: 'Sen',
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
                            padding: EdgeInsets.symmetric(
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
                                    interval: (barChartList.reduce(
                                                (value, element) =>
                                                    value > element
                                                        ? value
                                                        : element) ~/
                                            4)
                                        .toDouble(),
                                    showTitles: true,
                                  )),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                                // maxY: barChartList
                                //     .reduce((value, element) =>
                                //         value > element ? value : element)
                                //     .toDouble(),
                                // minY: 0,
                                gridData: FlGridData(show: false),
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
                                              toY: barChartList[index]
                                                  .toDouble(),
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                  softWrap: true, // Enable text wrapping
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  'NGN 7,000',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xFFEC2623),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: Text(
                              formattedDateTime,
                              style: const TextStyle(
                                color: Color(0xFF929292),
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
      ),
    );
  }
}
