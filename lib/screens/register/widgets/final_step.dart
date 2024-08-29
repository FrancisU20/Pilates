import 'package:flutter/cupertino.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class FinalStep extends StatelessWidget {
  const FinalStep({
    super.key,
    required this.texts,
  });

  final Texts texts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12 * SizeConfig.heightMultiplier,
      width: 70 * SizeConfig.widthMultiplier,
      child: Column(
        children: [
          texts.normalText(
              text: '¡Has completado la primera parte del registro!',
              fontWeight: FontWeight.w400),
          texts.normalText(
              text: 'Ahora puedes seleccionar un plan.',
              fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}
