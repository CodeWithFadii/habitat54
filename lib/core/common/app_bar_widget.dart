import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/constants/app_constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    this.showTrailing = true,
    this.trailing,
  });
  final bool showTrailing;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.7), // Shadow color
              spreadRadius: 0.1, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(5,
                  0), // Offset in the vertical direction (negative for top shadow)
            ),
          ],
        ),
        child: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleSpacing: 0.0,
          toolbarHeight: 90.0,
          title: Row(
            children: [
              const SizedBox(width: 8),
              Image.asset(AppConstants.logo,
                  height: 80, alignment: Alignment.centerLeft),
            ],
          ),
          actions: [
            showTrailing ? trailing ?? const SizedBox() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
