import 'package:flutter/material.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/utils/size_config.dart';

class ImagesContainers {
  Widget imageContainer({
    required String imageUrl,
    required double width,
    required double height,
    bool isDegraded = false,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
                15), // Ajusta el valor según el radio de borde que desees
            child: Image.asset(
              imageUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          isDegraded
              ? Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        15), // Aplica el mismo radio al degradado
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        ColorsPalette.white.withOpacity(1),
                        Colors.transparent,
                      ],
                      stops: const [0.5, 1],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget fullScreenImage({required String imageUrl, bool isDegraded = false}) {
    return imageContainer(
      imageUrl: imageUrl,
      width: double.infinity,
      height: double.infinity,
      isDegraded: isDegraded,
    );
  }

  Widget largeImage(String imageUrl) {
    return imageContainer(
      imageUrl: imageUrl,
      width: 70 * SizeConfig.widthMultiplier,
      height: 50 * SizeConfig.heightMultiplier,
    );
  }

  Widget mediumImage(String imageUrl) {
    return imageContainer(
      imageUrl: imageUrl,
      width: 50 * SizeConfig.widthMultiplier,
      height: 30 * SizeConfig.heightMultiplier,
    );
  }

  Widget smallImage(String imageUrl) {
    return imageContainer(
      imageUrl: imageUrl,
      width: 30 * SizeConfig.widthMultiplier,
      height: 10 * SizeConfig.heightMultiplier,
    );
  }

  Widget squareImage(String imageUrl) {
    return imageContainer(
      imageUrl: imageUrl,
      width: 50 * SizeConfig.widthMultiplier,
      height: 50 * SizeConfig.widthMultiplier,
    );
  }
}
