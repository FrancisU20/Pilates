import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';

class StepperWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepperWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index % 2 == 0) {
          // Segmento del paso
          int stepIndex = index ~/ 2;
          double width;
          if (stepIndex < currentStep) {
            width = 15.0;
          } else if (stepIndex == currentStep) {
            width = 30.0;
          } else {
            width = 15.0;
          }
          return Container(
            width: width,
            height: 4,
            decoration: BoxDecoration(
              color: stepIndex == currentStep
                  ? AppColors.brown200
                  : AppColors.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        } else {
          // Espacio entre segmentos
          return const SizedBox(width: 8);
        }
      }),
    );
  }
}
