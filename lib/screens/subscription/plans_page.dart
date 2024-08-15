import 'package:flutter/material.dart';
import 'package:pilates/screens/register/register_page.dart';
import 'package:pilates/screens/subscription/widgets/suscription_option_widget.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  SubscriptionPageState createState() => SubscriptionPageState();
}

class SubscriptionPageState extends State<SubscriptionPage> {
  final ImagesContainers imagesContainers = ImagesContainers();
  final Texts texts = Texts();
  final Buttons buttons = Buttons();
  int selectedOption = 0;

  void _selectOption(int index) {
    setState(() {
      selectedOption = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          imagesContainers.fullScreenImage(
              imageUrl:
                  'https://images.pexels.com/photos/6246397/pexels-photo-6246397.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              isDegraded: true),
          // Contenido
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                texts.titleText(
                  text: 'Suscríbete a uno de nuestros planes',
                  color: ColorsPalette.secondaryColor,
                  fontSize: 40,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 1 * SizeConfig.heightMultiplier),
                texts.normalText(
                    text:
                        'Selecciona un plan y disfruta de todos los beneficios, comienza a mejorar tu salud y bienestar:',
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    textAlign: TextAlign.start),
                SizedBox(height: 2 * SizeConfig.heightMultiplier),
                GestureDetector(
                  onTap: () => _selectOption(0),
                  child: SubscriptionOptionWidget(
                    duration: '1 Month',
                    price: '\$19.00',
                    description:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    isSelected: selectedOption == 0,
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectOption(1),
                  child: SubscriptionOptionWidget(
                    duration: '6 Month',
                    price: '\$79.00',
                    description:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    isSelected: selectedOption == 1,
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectOption(2),
                  child: SubscriptionOptionWidget(
                    duration: '1 Year',
                    price: '\$149.00',
                    description:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    isSelected: selectedOption == 2,
                  ),
                ),
                const SizedBox(height: 24.0),
                Center(
                    child: buttons.standart(
                        text: 'Suscribirse',
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            ),
                        color: ColorsPalette.primaryColor)),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
