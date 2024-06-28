import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';

class SellTimeLine extends StatelessWidget {
  const SellTimeLine({
    super.key,
    required this.step,
  });
  final int step;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Divider(
                  thickness: 2.5,
                  color: step > 1 ? AppColors.primary : AppColors.lightGrey,
                ),
              ),
              Flexible(
                child: Divider(
                  thickness: 2.5,
                  color: step > 2 ? AppColors.primary : AppColors.lightGrey,
                ),
              ),
              Flexible(
                child: Divider(
                  thickness: 2.5,
                  color: step >= 4 ? AppColors.primary : AppColors.lightGrey,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: step >= 1 ? AppColors.primary : AppColors.grey,
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Text(
                    'Basic',
                    style: TextStyle(
                        color: AppColors.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: step >= 2 ? AppColors.primary : AppColors.grey,
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Text(
                    'Address',
                    style: TextStyle(
                        color: AppColors.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: step >= 3 ? AppColors.primary : AppColors.grey,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Text(
                    'Additional',
                    style: TextStyle(
                        color: AppColors.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: step >= 4 ? AppColors.primary : AppColors.grey,
                    ),
                    child: const Text(
                      '4',
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Text(
                    'Media',
                    style: TextStyle(
                        color: AppColors.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
