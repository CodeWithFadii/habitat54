import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class DetailTileWidget extends StatelessWidget {
  const DetailTileWidget({
    super.key,
    required this.title1,
    required this.value1,
    this.title2,
    this.value2,
  });

  final String title1;
  final String value1;

  final String? title2;
  final String? value2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Text(
                '$title1 : ',
                style: AppTextStyle.boldBlack16.copyWith(color: AppColors.grey),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value1,
                style: AppTextStyle.boldBlack16,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Wrap(
            children: [
              Text(
               title2 == null? '': '$title2 : ',
                style: AppTextStyle.boldBlack16.copyWith(color: AppColors.grey),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value2 ?? '',
                style: AppTextStyle.boldBlack16,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        ],
      ),
    );
  }
}
