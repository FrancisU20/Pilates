import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/integrations/whatsapp_launcher.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/screens/client/payment-methods/widgets/plan_status_disclaimer.dart';
import 'package:pilates/theme/components/common/app_bank_details.dart';
import 'package:pilates/theme/components/client/client_identification.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';
import 'package:pilates/screens/client/payment-methods/widgets/plan_details.dart';
import 'package:pilates/theme/widgets/custom_app_bar.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class TransferPaymentPage extends StatefulWidget {
  const TransferPaymentPage({super.key});

  @override
  TransferPaymentPageState createState() => TransferPaymentPageState();
}

class TransferPaymentPageState extends State<TransferPaymentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        return Consumer<UserPlanProvider>(
          builder: (context, userPlanProvider, child) {
            DateTime planStart = DateTime.now();
            DateTime planExpiration = planStart.add(Duration(
                days: userPlanProvider.selectedPlan!.classesValidityPeriod));
            return Scaffold(
              backgroundColor: AppColors.white100,
              appBar: const CustomAppBar(backgroundColor: AppColors.brown200, toDashboard: true),
              body: Stack(children: [
                Container(
                  color: AppColors.brown200,
                  child: Column(
                    children: [
                      const CustomPageHeader(
                          icon: FontAwesomeIcons.moneyBill,
                          title: 'CheckOut',
                          subtitle: 'Transferencia bancaria'),
                      SizedBox(
                        height: SizeConfig.scaleHeight(2),
                      ),
                      Flexible(
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
                                  Visibility(
                                    visible:
                                        userPlanProvider.userPaymentImage == '',
                                    child: Column(
                                      children: [
                                        Center(
                                          child: CustomText(
                                              text: 'Verifica tu carné virtual',
                                              color: AppColors.black100,
                                              fontSize:
                                                  SizeConfig.scaleText(2.5),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(2),
                                        ),
                                        ClientIdentification(
                                          loginProvider: loginProvider,
                                          userPlanProvider: userPlanProvider,
                                        ),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(2),
                                        ),
                                        PlanDetails(
                                            userPlanProvider: userPlanProvider,
                                            planStart: planStart,
                                            planExpiration: planExpiration),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(2),
                                        ),
                                        const AppBankDetails(),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        userPlanProvider.userPaymentImage != '',
                                    child: Column(
                                      children: [
                                        Center(
                                          child: CustomText(
                                              text: 'Ya casi terminamos',
                                              color: AppColors.black100,
                                              fontSize:
                                                  SizeConfig.scaleText(2.5),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(2),
                                        ),
                                        const PlanStatusDisclaimer(),
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(2),
                                        ),
                                        CustomButton(onPressed: () {
                                          whatsappServices.whatsappRedirect(message: 'Hola, necesito ayuda con la activación de mi plan. Mi número de cédula es ${loginProvider.user!.dniNumber}');
                                        }, text: 'Informar pago', color: AppColors.brown200, icon: FontAwesomeIcons.whatsapp),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ]),
              floatingActionButton: userPlanProvider.userPaymentImage != ''
                  ? null
                  : FloatingActionButton(
                      onPressed: () {
                        AppDialogs.showTransferPaymentPicker(
                            context, loginProvider.user!.dniNumber);
                      },
                      backgroundColor: AppColors.brown200,
                      child: const Icon(
                        FontAwesomeIcons.camera,
                        color: AppColors.white100,
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
