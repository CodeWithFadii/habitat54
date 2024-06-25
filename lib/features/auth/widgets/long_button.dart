import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.height = 48,
    this.color = AppColors.primary,
    this.textColor = AppColors.white,
  });
  final VoidCallback onPressed;
  final String text;
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;
  

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      elevation: 0,
      height: height,
      minWidth: width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: AppTextStyle.mediumWhite18.copyWith(color: textColor),
      ),
    );
  }
}
