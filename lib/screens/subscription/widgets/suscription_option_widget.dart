import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/texts.dart';

class SubscriptionOptionWidget extends StatelessWidget {
  final String duration;
  final String price;
  final String description;
  final bool isSelected;

  final Texts texts = Texts();

  SubscriptionOptionWidget({
    super.key,
    required this.duration,
    required this.price,
    required this.description,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isSelected ? ColorsPalette.secondaryColor : Colors.grey,
          width: 2.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                texts.normalText(
                  text: duration,
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 4.0),
                texts.normalText(
                    text: description,
                    color: Colors.grey.shade700,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start),
              ],
            ),
          ),
          Text(
            price,
            style: GoogleFonts.roboto(
              color: ColorsPalette.secondaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
