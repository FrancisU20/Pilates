import 'package:flutter/cupertino.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.scaleHeight(8),
      width: SizeConfig.scaleWidth(70),
      child: Column(
        children: [
          CustomText(
              text: '¡Has completado tu registro ahora puedes iniciar sesión en el App!',
              fontWeight: FontWeight.w400, fontSize: SizeConfig.scaleText(2),maxLines: 2,),
        ],
      ),
    );
  }
}
