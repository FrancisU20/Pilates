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
      height: 10 * SizeConfig.heightMultiplier,
      child: Column(
        children: [
          texts.normalText(
              text: '¡Gracias por registrarte!', fontWeight: FontWeight.w400),
          texts.normalText(
              text: 'Ahora puedes empezar a usar la app.',
              fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}
