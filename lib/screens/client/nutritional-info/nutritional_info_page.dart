import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/personal_info.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_app_bar.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class NutritionalInfoPage extends StatefulWidget {
  const NutritionalInfoPage({super.key});

  @override
  NutritionalInfoPageState createState() => NutritionalInfoPageState();
}

class NutritionalInfoPageState extends State<NutritionalInfoPage> {
  TextEditingController completeNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NutritionalInfoProvider>(context, listen: false).clearData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white100,
          appBar: const CustomAppBar(backgroundColor: AppColors.brown200),
          body: Container(
            color: AppColors.brown200,
            child: Column(
              children: [
                const CustomPageHeader(
                    icon: FontAwesomeIcons.boxesStacked,
                    title: 'Ficha Nutricional',
                    subtitle: 'Ingresa o actualiza tu información'),
                SizedBox(
                  height: SizeConfig.scaleHeight(2),
                ),
                Consumer<NutritionalInfoProvider>(
                  builder: (context, nutritionalInfoProvider, child) {
                    if (nutritionalInfoProvider.hasNutritionalInfo == false) {
                      return AppEmptyData(
                          imagePath:
                              'https://curvepilates-bucket.s3.amazonaws.com/app-assets/clipboard/empty-clipboard.png',
                          message:
                              'Aún no has completado tu ficha nutricional. Crea una nueva y agrega tu información.',
                          buttonText: 'Crear Ficha',
                          onButtonPressed: () {
                            nutritionalInfoProvider.setHasNutritionalInfo(true);
                          },
                          buttonIcon: FontAwesomeIcons.plus);
                    } else {
                      return Flexible(
                        child: Container(
                            width: SizeConfig.scaleWidth(100),
                            height: SizeConfig.scaleHeight(78),
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.scaleWidth(5),
                                vertical: SizeConfig.scaleHeight(2)),
                            decoration: const BoxDecoration(
                                color: AppColors.white100,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              physics: const ClampingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(2),
                                  ),
                                  PersonalInformation(
                                      completeNameController:
                                          completeNameController,
                                      birthDateController: birthDateController,
                                      ageController: ageController,
                                      genderController: genderController,
                                      maritalStatusController:
                                          maritalStatusController,
                                      addressController: addressController,
                                      occupationController: occupationController,
                                      phoneController: phoneController,
                                      emailController: emailController),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(2),
                                  ),
                                  Center(
                                    child: CustomText(
                                        text: 'Hábitos Alimenticios',
                                        color: AppColors.black100,
                                        fontSize: SizeConfig.scaleText(2.5),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(2),
                                  ),
                                  Center(
                                    child: CustomText(
                                        text: 'Antecedentes Heredofamiliares',
                                        color: AppColors.black100,
                                        fontSize: SizeConfig.scaleText(2.5),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(2),
                                  ),
                                  Center(
                                    child: CustomText(
                                        text: 'Medidas Antropométricas',
                                        color: AppColors.black100,
                                        fontSize: SizeConfig.scaleText(2.5),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Consumer<NutritionalInfoProvider>(
          builder: (context, nutritionalInfoProvider, child) {
            if (nutritionalInfoProvider.isLoading) {
              return const AppLoading();
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
