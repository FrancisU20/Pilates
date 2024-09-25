import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/utils/size_config.dart';

class PieDataWidget extends StatefulWidget {
  final int totalActivePlans;
  final int totalInactivePlans;

  const PieDataWidget({
    super.key,
    required this.totalActivePlans,
    required this.totalInactivePlans,
  });

  @override
  PieDataWidgetState createState() => PieDataWidgetState();
}

class PieDataWidgetState extends State<PieDataWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90 * SizeConfig.widthMultiplier,
      height: 15 * SizeConfig.heightMultiplier,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          startDegreeOffset: 180,
          borderData: FlBorderData(show: false),
          sectionsSpace: 1,
          centerSpaceRadius: 0,
          sections: [
            PieChartSectionData(
              color: ColorsPalette.primaryColor,
              value: widget.totalActivePlans.toDouble(),
              title: widget.totalActivePlans.toString(),
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff),
              ),
            ),
            PieChartSectionData(
              color: const Color.fromARGB(255, 84, 80, 80),
              value: widget.totalInactivePlans.toDouble(),
              title: widget.totalInactivePlans.toString(),
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
