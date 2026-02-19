import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const AppText(
      this.text, {
        super.key,
        this.fontSize = 18,
        this.fontWeight = FontWeight.normal,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: AppColors.black,
      ),
    );
  }
}
