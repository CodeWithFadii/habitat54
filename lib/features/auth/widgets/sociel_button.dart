
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.image,
    required this.onTap,
  });
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 64,
        width: 92,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(image),
      ),
    );
  }
}