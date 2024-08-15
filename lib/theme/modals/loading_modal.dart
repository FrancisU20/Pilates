import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/paths/images.dart';
import 'package:pilates/utils/size_config.dart';

class LoadingModal extends StatelessWidget {
  final Texts texts = Texts();

  LoadingModal({super.key});

  void showLoadingModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingModal();
      },
    );
  }

  void closeLoadingModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(25 * SizeConfig.heightMultiplier),
              ),
              clipBehavior: Clip.hardEdge,
              height: 25 * SizeConfig.heightMultiplier,
              child: Image.asset(
                images.logoSquare,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 5 * SizeConfig.heightMultiplier),
            LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white, size: 7.5 * SizeConfig.heightMultiplier),
          ],
        ),
      ),
    );
  }
}
