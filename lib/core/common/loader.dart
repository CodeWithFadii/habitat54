import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: AppColors.primary, // Replace with your color
        ),
      ),
    );
  }
}
