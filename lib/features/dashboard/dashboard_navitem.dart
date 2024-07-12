import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class DashboardNavItem extends StatelessWidget {
  const DashboardNavItem({
    super.key,
    required this.isActive,
    this.onTap,
    required this.icon,
    required this.text,
    this.size,
  });
  final bool isActive;
  final Function()? onTap;
  final IconData icon;
  final double? size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.grey,
            size: 26,
          ),
          // Image.asset(
          //   icon,
          //   height: size ?? 21,
          //   color: isActive ? AppColors.primary : AppColors.grey,
          // ),
          const SizedBox(height: 5),
          Text(
            text,
            style: AppTextStyle.regularBlack14.copyWith(
              color: isActive ? AppColors.primary : AppColors.grey,
            ),
          )
        ],
      ),
    );
  }
}
