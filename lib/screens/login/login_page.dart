import 'package:flutter/material.dart';
import 'package:pilates/screens/login/widgets/login_form.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/textfields.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/paths/images_paths.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  Texts texts = Texts();
  Buttons buttons = Buttons();
  TextFormFields textFormFields = TextFormFields();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsPalette.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagesPaths.backgroundLogin),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  ColorsPalette.black.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginForm(
                    formKey: formKey,
                    textFormFields: textFormFields,
                    texts: texts)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
