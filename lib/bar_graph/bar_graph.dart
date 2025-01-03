import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:trackify/bar_graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
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
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles:SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTile,
            )
          )
        ),

        barGroups: mybardata.barData
            .map(
                (data)=>BarChartGroupData(
                    x: data.x,
                  barRods: [
                    BarChartRodData(
                        toY: data.y,
                      color: Colors.brown[800],
                      borderRadius: BorderRadius.circular(4),
                      width: 25,
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY,
                        color: Colors.brown[300]
                      ),
                    )
                  ]
                ),
        )
            .toList(),

      )
    );
  }
}
Widget getBottomTile(double value, TitleMeta meta){
  const style = TextStyle(
    color: Colors.brown,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch(value.toInt()){
    case 0 :
      text = const Text('S', style: style);
    case 1 :
      text = const Text('M', style: style);
    case 2 :
      text = const Text('T', style: style);
    case 3 :
      text = const Text('W', style: style);
    case 4 :
      text = const Text('T', style: style);
    case 5 :
      text = const Text('F', style: style);
    case 6 :
      text = const Text('S', style: style);
    default :
      text = const Text(' ', style: style);
  }
  return SideTitleWidget(
      child: text,
      axisSide: meta.axisSide
  );
}