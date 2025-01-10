import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class ViewMonth extends StatelessWidget {
  final CalendarFormat calendarFormat;
  final Function(CalendarFormat) onToggle;

  const ViewMonth({
    super.key,
    required this.calendarFormat,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del Row al contenido
          children: [
            CustomText(
              text: 'Ver mes',
              fontSize:SizeConfig.scaleText(2),
            ),
            IconButton(
              icon: Icon(
                calendarFormat == CalendarFormat.week
                    ? FontAwesomeIcons.toggleOff
                    : FontAwesomeIcons.toggleOn,
              ),
              color: AppColors.black100,
              onPressed: () {
                onToggle(
                  calendarFormat == CalendarFormat.week
                      ? CalendarFormat.month
                      : CalendarFormat.week,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
