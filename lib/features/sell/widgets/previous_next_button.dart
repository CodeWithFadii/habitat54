import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class PreviousNextButton extends StatelessWidget {
  const PreviousNextButton({
    super.key,
    required this.previous,
    required this.next, this.nextText,
  });
  final VoidCallback previous;
  final VoidCallback next;
  final String? nextText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 185,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: MaterialButton(
            onPressed: previous,
            color: AppColors.grey,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  'Previous Step',
                  style: AppTextStyle.mediumWhite14,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 185,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: MaterialButton(
            onPressed: next,
            color: AppColors.primary,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nextText??  'Continue',
                  style: AppTextStyle.mediumWhite14,
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
