import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualizer/constants.dart';

class SortingScatterChart extends StatelessWidget {
  final List<ScatterSpot> scatterSpots;
  const SortingScatterChart({
    required this.scatterSpots,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScatterChart(
      ScatterChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          scatterSpots: scatterSpots,
          maxX: elements - 1,
          maxY: elements - 1,
          minX: 0,
          minY: 0),
      swapAnimationDuration: Duration.zero, // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}

class SortButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const SortButton({required this.text,required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: btnColor,
      textColor: btnTextColor,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
