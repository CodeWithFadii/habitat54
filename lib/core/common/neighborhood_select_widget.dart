import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class NeighborhoodSelectWidget extends StatelessWidget {
  const NeighborhoodSelectWidget({
    super.key,
    required this.onPressed,
    required this.neighborhood,
  });

  final VoidCallback onPressed;
  final String neighborhood;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.black, width: 1.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: neighborhood.isNotEmpty
              ? [
                  Text(neighborhood, style: AppTextStyle.regularBlack16),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 97, 97, 97),
                  )
                ]
              : [
                  const SizedBox(),
                  Text(
                    'Neighborhood',
                    style: AppTextStyle.regularBlack16.copyWith(
                        color: AppColors.grey, fontStyle: FontStyle.italic),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 97, 97, 97),
                  )
                ],
        ),
      ),
    );
  }
}
