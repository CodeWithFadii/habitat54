import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

Widget alertDialog() {
  return AlertDialog(
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(),
    contentPadding: const EdgeInsets.all(15),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Are you sure to quit ?',
          style: AppTextStyle.boldBlack16,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                // Get.offAll(() => LoginScreen());
              },
              color: AppColors.white,
              elevation: 6,
              height: 38,
              minWidth: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Cancel',
                style: AppTextStyle.mediumBlack12,
              ),
            ),
            const SizedBox(width: 20),
            MaterialButton(
              onPressed: () {
                // Get.offAll(() => LoginScreen());
              },
              color: AppColors.primary,
              elevation: 0,
              height: 38,
              minWidth: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Ok',
                style: AppTextStyle.mediumWhite12,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
