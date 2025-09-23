import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:simple_expense_tracker/features/home/data/controller/graph_controller.dart';

class HomeGraph extends StatefulWidget {
  const HomeGraph({super.key});

  @override
  _HomeGraphState createState() => _HomeGraphState();
}

class _HomeGraphState extends State<HomeGraph> {
  List<Color> gradientColors = [
    const Color(0xff1EAE67),
    const Color(0xff1EAE90),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GraphController>(
      builder: (gc) {
        // Get weekly totals from controller
        final totals = gc.expensesOfFourWeeks.map((e) => e.cost).toList();
        // Ensure exactly 4 values
        while (totals.length < 4) {
          totals.add(0);
        }

        // Scale values to not exceed y-axis max (6)
        const double yMax = 6.0;
        final double maxVal = totals.isNotEmpty
            ? totals.reduce((a, b) => a > b ? a : b)
            : 0.0;
        final double scale = (maxVal > yMax && maxVal > 0)
            ? yMax / maxVal
            : 1.0;
        final scaled = totals.map((v) => (v * scale)).toList();

        return Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2,
              child: Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 25,
                  bottom: 15,
                ),
                child: LineChart(mainData(scaled)),
              ),
            ),
          ],
        );
      },
    );
  }

  LineChartData mainData(List<double> weeklyValues) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.grey.withOpacity(.2), strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: Colors.grey.withOpacity(.2), strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (double value, TitleMeta meta) {
              const style = TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );
              Widget text;
              switch (value.toInt()) {
                case 0:
                  text = Text("Week 1", style: style);
                  break;
                case 1:
                  text = Text("Week 2", style: style);
                  break;
                case 2:
                  text = Text("Week 3", style: style);
                  break;
                case 3:
                  text = Text("Week 4", style: style);
                  break;
                default:
                  text = const Text('', style: style);
                  break;
              }

              return SideTitleWidget(meta: meta, space: 8.0, child: text);
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 10,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(.3), width: 1),
      ),
      minX: 0,
      maxX: 3,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, weeklyValues.isNotEmpty ? weeklyValues[0] : 0),
            FlSpot(1, weeklyValues.length > 1 ? weeklyValues[1] : 0),
            FlSpot(2, weeklyValues.length > 2 ? weeklyValues[2] : 0),
            FlSpot(3, weeklyValues.length > 3 ? weeklyValues[3] : 0),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
