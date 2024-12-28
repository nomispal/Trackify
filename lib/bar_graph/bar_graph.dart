import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:trackify/bar_graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double maxY;
  final double sunAmount;
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thusAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.monAmount,
    required this.tuesAmount,
    required this.wedAmount,
    required this.thusAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  @override
  Widget build(BuildContext context) {

    BarData mybardata = BarData(
        monAmount: monAmount,
        tuesAmount: tuesAmount,
        wedAmount: wedAmount,
        thusAmount: thusAmount,
        friAmount: friAmount,
        satAmount: satAmount,
        sunAmount: sunAmount
    );

    mybardata.intializeBarData();
    
    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        barGroups: mybardata.barData
            .map(
                (data)=>BarChartGroupData(
                    x: data.x,
                  barRods: [
                    BarChartRodData(toY: data.y)
                  ]
                ),
        )
            .toList(),

      )
    );
  }
}
