// import fl_chart
import 'package:benji_rider/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartTest extends StatelessWidget {
  const BarChartTest({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'KindaCode.com',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KindaCode.com'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(30),
          // implement the bar chart
          child: BarChart(
            BarChartData(
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                  reservedSize: 50,
                  interval: 5,
                  showTitles: true,
                )),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              maxY: 25,
              minY: 0,
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
              barGroups: [
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(toY: 10, width: 15, color: kAccentColor),
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(toY: 9, width: 15, color: kAccentColor),
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(toY: 4, width: 15, color: kAccentColor),
                ]),
                BarChartGroupData(x: 4, barRods: [
                  BarChartRodData(toY: 2, width: 15, color: kAccentColor),
                ]),
                BarChartGroupData(x: 5, barRods: [
                  BarChartRodData(toY: 13, width: 15, color: kAccentColor),
                ]),
                BarChartGroupData(x: 6, barRods: [
                  BarChartRodData(toY: 17, width: 15, color: kAccentColor),
                ]),
                BarChartGroupData(x: 7, barRods: [
                  BarChartRodData(toY: 19, width: 15, color: kAccentColor),
                ]),
                BarChartGroupData(x: 8, barRods: [
                  BarChartRodData(toY: 21, width: 15, color: kAccentColor),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
