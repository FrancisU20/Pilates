import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/models/class/class_model.dart';
import 'package:pilates/providers/user-class/user_class_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class HourPicker extends StatefulWidget {
  final List<ClassModel> userClassList;

  const HourPicker({
    super.key,
    required this.userClassList,
  });

  @override
  HourPickerState createState() => HourPickerState();
}

class HourPickerState extends State<HourPicker> {
  @override
  void initState() {
    super.initState();
  }

  void _handlePicker(int index) {
    ClassProvider classProvider =
        Provider.of<ClassProvider>(context, listen: false);
    classProvider.setSelectedHourIndex(index);
    classProvider.setSelectedClass(widget.userClassList[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: SizeConfig.scaleHeight(1),
        left: SizeConfig.scaleWidth(4),
        right: SizeConfig.scaleWidth(4),
        bottom: SizeConfig.scaleHeight(1),
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      width: SizeConfig.scaleWidth(90),
      height: SizeConfig.scaleHeight(6),
      child:
          Consumer<ClassProvider>(builder: (context, classProvider, _) {
        return ListView.builder(
          itemCount: widget.userClassList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            bool isSelected = classProvider.selectedHourIndex == index;
            return GestureDetector(
              onTap: () => _handlePicker(index),
              child: Row(
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: widget.userClassList[index].schedule!.startHour
                            .substring(0, 5),
                        color:
                            isSelected ? AppColors.gold100 : AppColors.grey200,
                        fontSize: SizeConfig.scaleText(2),
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        width: SizeConfig.scaleWidth(13),
                        height: SizeConfig.scaleHeight(0.15),
                        color:
                            isSelected ? AppColors.gold100 : AppColors.grey200,
                      ),
                    ],
                  ),
                  SizedBox(width: SizeConfig.scaleWidth(4)),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
