import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/constants/app_constants.dart';

class AuthSocielButton extends StatelessWidget {
  const AuthSocielButton({
    super.key,
    required this.google,
    // required this.facebook,
  });
  final VoidCallback google;
  // final VoidCallback facebook;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  'Or continue with',
                  style: AppTextStyle.regularBlack14
                      .copyWith(color: AppColors.grey),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: google,
              child: Container(
                padding: const EdgeInsets.all(12),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xfff4f4f4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(AppConstants.google),
              ),
            ),
            // GestureDetector(
            //   onTap: facebook,
            //   child: Container(
            //     padding: const EdgeInsets.all(12),
            //     margin:
            //         const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //     decoration: BoxDecoration(
            //       color: const Color(0xfff4f4f4),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Image.asset(AppConstants.facebook),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
