import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class StackSmallWidget extends StatelessWidget {
  const StackSmallWidget({
    super.key,
    this.widget,
  });
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      width: 40,
      decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: widget ??
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.white,
                size: 17,
              ),
              Text(
                '5',
                style: AppTextStyle.boldWhite12
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
    );
  }
}
