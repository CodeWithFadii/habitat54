import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class DetailTileWidget extends StatelessWidget {
  const DetailTileWidget({
    super.key,
    required this.title1,
    required this.value1,
    required this.title2,
    required this.value2,
  });

  final String title1;
  final String value1;

  final String title2;
  final String value2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Text(
                '$title1 : ',
                style: AppTextStyle.boldBlack16.copyWith(color: AppColors.grey),
              ),
              Text(
                value1,
                style: AppTextStyle.boldBlack16,
              ),
            ],
          ),
          Wrap(
            children: [
              Text(
                '$title2 : ',
                style: AppTextStyle.boldBlack16.copyWith(color: AppColors.grey),
              ),
              Text(
                value2,
                style: AppTextStyle.boldBlack16,
              ),
            ],
          )
        ],
      ),
    );
  }
}
