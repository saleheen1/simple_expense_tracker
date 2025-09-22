import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2,
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 15),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
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
                  text = Text("Sat", style: style);
                  break;
                case 1:
                  text = Text("Sun", style: style);
                  break;
                case 2:
                  text = Text("Mon", style: style);
                  break;
                case 3:
                  text = Text("Tue", style: style);
                  break;
                case 4:
                  text = Text("Wed", style: style);
                  break;
                case 5:
                  text = Text("Thu", style: style);
                  break;
                case 6:
                  text = Text("Fri", style: style);
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
      maxX: 6,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(1, 4),
            FlSpot(2, 2),
            FlSpot(3, 5),
            FlSpot(4, 2),
            FlSpot(5, 3),
            FlSpot(6, 2),
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
