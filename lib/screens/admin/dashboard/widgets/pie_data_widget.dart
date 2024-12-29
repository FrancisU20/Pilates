import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';

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
              color: ColorsPalette.beigeAged,
              value: widget.totalActivePlans.toDouble(),
              title: widget.totalActivePlans.toString(),
              radius: 50,
              titleStyle:  TextStyle(
                fontSize: 2.5 * SizeConfig.heightMultiplier,
                fontWeight: FontWeight.bold,
                color: ColorsPalette.white,
              ),
            ),
            PieChartSectionData(
              color: ColorsPalette.greyAged,
              value: widget.totalInactivePlans.toDouble(),
              title: widget.totalInactivePlans.toString(),
              radius: 50,
              titleStyle:  TextStyle(
                fontSize: 2.5 * SizeConfig.heightMultiplier,
                fontWeight: FontWeight.bold,
                color: ColorsPalette.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
