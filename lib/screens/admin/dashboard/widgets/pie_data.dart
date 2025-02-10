import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text.dart';

class PieData extends StatefulWidget {
  final AdminProvider adminProvider;

  const PieData({
    super.key,
    required this.adminProvider,
  });

  @override
  PieDataState createState() => PieDataState();
}

class PieDataState extends State<PieData> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
            text: 'Información de planes ',
            color: AppColors.black100,
            fontSize:SizeConfig.scaleText(2.2
            ),
            fontWeight: FontWeight.w500),
        SizedBox(
          height: SizeConfig.scaleHeight(0.5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: SizeConfig.scaleHeight(1),
                    color: AppColors.green200,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CustomText(
                      text: 'Activos',
                      color: AppColors.green200,
                      fontSize:SizeConfig.scaleText(1.5),
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
            SizedBox(width: SizeConfig.scaleWidth(2)),
            SizedBox(
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: SizeConfig.scaleHeight(1),
                    color: AppColors.blue200,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CustomText(
                      text: 'Completados',
                      color: AppColors.blue200,
                      fontSize:SizeConfig.scaleText(1.5),
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
            SizedBox(width: SizeConfig.scaleWidth(2)),
            SizedBox(
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: SizeConfig.scaleHeight(1),
                    color: AppColors.orange300,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CustomText(
                      text: 'Expirados',
                      color: AppColors.orange300,
                      fontSize:SizeConfig.scaleText(1.5),
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
            SizedBox(width: SizeConfig.scaleWidth(2)),
            SizedBox(
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: SizeConfig.scaleHeight(1),
                    color: AppColors.red300,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CustomText(
                      text: 'Inactivos',
                      color: AppColors.red300,
                      fontSize:SizeConfig.scaleText(1.5),
                      fontWeight: FontWeight.w500),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: SizeConfig.scaleHeight(30),
          child: PieChart(
            PieChartData(
              centerSpaceColor: AppColors.white100,
              titleSunbeamLayout: false,
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
              startDegreeOffset: 20,
              borderData: FlBorderData(show: false),
              sectionsSpace: SizeConfig.scaleHeight(0.1),
              centerSpaceRadius: SizeConfig.scaleHeight(4),
              sections: [
                PieChartSectionData(
                  color: AppColors.green200,
                  value: widget.adminProvider.listUserPlans
                      .where((element) => element.status == 'A')
                      .length
                      .toDouble(),
                  title: widget.adminProvider.listUserPlans
                      .where((element) => element.status == 'A')
                      .length
                      .toString(),
                  radius: SizeConfig.scaleHeight(10),
                  titleStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: AppColors.white100,
                      fontSize:SizeConfig.scaleText(1.6),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                ),
                PieChartSectionData(
                  color: AppColors.blue200,
                  value: widget.adminProvider.listUserPlans
                      .where((element) => element.status == 'C')
                      .length
                      .toDouble(),
                  title: widget.adminProvider.listUserPlans
                      .where((element) => element.status == 'C')
                      .length
                      .toString(),
                  radius: SizeConfig.scaleHeight(10),
                  titleStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: AppColors.white100,
                      fontSize:SizeConfig.scaleText(1.6),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                ),
                PieChartSectionData(
                  color: AppColors.orange300,
                  value: widget.adminProvider.listUserPlans
                      .where((element) => element.status == 'E')
                      .length
                      .toDouble(),
                  title: widget.adminProvider.listUserPlans
                      .where((element) => element.status == 'E')
                      .length
                      .toString(),
                  radius: SizeConfig.scaleHeight(10),
                  titleStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: AppColors.white100,
                      fontSize:SizeConfig.scaleText(1.6),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                ),
                PieChartSectionData(
                  color: AppColors.red300,
                  value: widget.adminProvider.listUserPlans
                      .where((element) => element.status == 'I')
                      .length
                      .toDouble(),
                  title: widget.adminProvider.listUserPlans
                      .where((element) => element.status == 'I')
                      .length
                      .toString(),
                  radius: SizeConfig.scaleHeight(10),
                  titleStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: AppColors.white100,
                      fontSize:SizeConfig.scaleText(1.6),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      height: 0.9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
