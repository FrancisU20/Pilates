import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/config/images_paths.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/providers/class/class_provider.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/providers/plan/plan_provider.dart';
import 'package:pilates/providers/recover-password/recover_password_provider.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/providers/user-class/user_class_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // Combina todos los estados de carga en una sola expresión
    final isAnyLoading = context.watch<RegisterProvider>().isLoading ||
        context.watch<LoginProvider>().isLoading ||
        context.watch<PlanProvider>().isLoading ||
        context.watch<UserPlanProvider>().isLoading ||
        context.watch<NutritionalInfoProvider>().isLoading ||
        context.watch<ClassProvider>().isLoading ||
        context.watch<RecoverPasswordProvider>().isLoading ||
        context.watch<UserClassProvider>().isLoading ||
        context.watch<AdminProvider>().isLoading;

    return isAnyLoading
        ? Stack(
            children: [
              ModalBarrier(
                color: AppColors.black100.withOpacity(0.6),
                dismissible: false,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConfig.scaleHeight(25)),
                      ),
                      clipBehavior: Clip.hardEdge,
                      height: SizeConfig.scaleHeight(25),
                      child: Image.asset(
                        imagesPaths.logoSquareFill,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(5)),
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.white100,
                      size: SizeConfig.scaleHeight(7.5),
                    ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}