import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/common/custom_app_bar.dart';

class PDFViewerPage extends StatelessWidget {
  final String filePath;

  const PDFViewerPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backgroundColor: AppColors.brown200),
      body: PDFView(
        filePath: filePath,
        backgroundColor: AppColors.white200,
        autoSpacing: true,
      ),
    );
  }
}
