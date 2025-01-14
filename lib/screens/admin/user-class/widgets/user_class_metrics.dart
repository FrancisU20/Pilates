import 'package:flutter/material.dart';
import 'package:pilates/models/user-class/user_class_model.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class UserClassMetrics extends StatelessWidget {
  final List<UserClassModel> listUserClass;
  final bool isHistory;

  const UserClassMetrics(
      {super.key, required this.listUserClass, required this.isHistory});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (!isHistory) ...[
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
                decoration: BoxDecoration(
                  color: AppColors.blue200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                    topRight: Radius.circular(SizeConfig.scaleHeight(2)),
                  ),
                ),
                width: SizeConfig.scaleWidth(25),
                child: Column(
                  children: [
                    Center(
                      child: CustomText(
                        text: listUserClass
                            .where((userClass) => userClass.status == 'A')
                            .toList()
                            .length
                            .toString(),
                        color: AppColors.white100,
                        fontSize: SizeConfig.scaleText(2),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
                width: SizeConfig.scaleWidth(25),
                decoration: BoxDecoration(
                  color: AppColors.white200,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                    bottomRight: Radius.circular(SizeConfig.scaleHeight(2)),
                  ),
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Clases',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(1.2),
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: 'Agendadas',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(1.4),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              )
            ],
          ),
        ] else ...[
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
                decoration: BoxDecoration(
                  color: AppColors.green200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                    topRight: Radius.circular(SizeConfig.scaleHeight(2)),
                  ),
                ),
                width: SizeConfig.scaleWidth(25),
                child: Column(
                  children: [
                    Center(
                      child: CustomText(
                        text: listUserClass
                            .where((userClass) => userClass.status == 'C')
                            .toList()
                            .length
                            .toString(),
                        color: AppColors.white100,
                        fontSize: SizeConfig.scaleText(2),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
                width: SizeConfig.scaleWidth(25),
                decoration: BoxDecoration(
                  color: AppColors.white200,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                    bottomRight: Radius.circular(SizeConfig.scaleHeight(2)),
                  ),
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Clases',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(1.2),
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: 'Completadas',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(1.4),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
                decoration: BoxDecoration(
                  color: AppColors.orange300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                    topRight: Radius.circular(SizeConfig.scaleHeight(2)),
                  ),
                ),
                width: SizeConfig.scaleWidth(25),
                child: Column(
                  children: [
                    Center(
                      child: CustomText(
                        text: listUserClass
                            .where((userClass) => userClass.status == 'E')
                            .toList()
                            .length
                            .toString(),
                        color: AppColors.white100,
                        fontSize: SizeConfig.scaleText(2),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
                width: SizeConfig.scaleWidth(25),
                decoration: BoxDecoration(
                  color: AppColors.white200,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                    bottomRight: Radius.circular(SizeConfig.scaleHeight(2)),
                  ),
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Clases',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(1.2),
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: 'Expiradas',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(1.4),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
                decoration: BoxDecoration(
                  color: AppColors.red300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                    topRight: Radius.circular(SizeConfig.scaleHeight(2)),
                  ),
                ),
                width: SizeConfig.scaleWidth(25),
                child: Column(
                  children: [
                    Center(
                      child: CustomText(
                        text: listUserClass
                            .where((userClass) => userClass.status == 'X')
                            .toList()
                            .length
                            .toString(),
                        color: AppColors.white100,
                        fontSize: SizeConfig.scaleText(2),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(SizeConfig.scaleHeight(1)),
                width: SizeConfig.scaleWidth(25),
                decoration: BoxDecoration(
                  color: AppColors.white200,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeConfig.scaleHeight(2)),
                    bottomRight: Radius.circular(SizeConfig.scaleHeight(2)),
                  ),
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Clases',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(1.2),
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: 'Canceladas',
                      color: AppColors.black100,
                      fontSize: SizeConfig.scaleText(1.4),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              )
            ],
          ),
        ]
      ],
    );
  }
}
