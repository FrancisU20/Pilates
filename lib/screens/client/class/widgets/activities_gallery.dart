import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';

class ActivitiesGallery extends StatelessWidget {
  final List<Map<String, String>> activitiesData;

  const ActivitiesGallery({
    super.key,
    required this.activitiesData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.scaleWidth(90),
      height: SizeConfig.scaleHeight(42),
      child: ListView.builder(
        itemCount: activitiesData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                width: SizeConfig.scaleWidth(60),
                height: SizeConfig.scaleHeight(40),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      activitiesData[index]['image']!,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.scaleHeight(31),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: SizeConfig.scaleHeight(2),
                        left: SizeConfig.scaleWidth(4),
                        right: SizeConfig.scaleWidth(4),
                        bottom: SizeConfig.scaleHeight(1),
                      ),
                      width: SizeConfig.scaleWidth(50),
                      height: SizeConfig.scaleHeight(9),
                      decoration: BoxDecoration(
                        color: AppColors.white100.withOpacity(0.8),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: activitiesData[index]['description']!,
                            color: AppColors.black100,
                            fontSize: SizeConfig.scaleText(2),
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.start,
                          ),
                          CustomText(
                            text: 'Curve Pilates',
                            color: AppColors.brown200,
                            fontSize: SizeConfig.scaleText(1.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: SizeConfig.scaleWidth(2),
              ),
            ],
          );
        },
      ),
    );
  }
}
