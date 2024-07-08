import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    super.key,
    required this.phonePressed,
    required this.messagePressed,
    required this.number,
  });

  final VoidCallback phonePressed;
  final VoidCallback messagePressed;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: phonePressed,
            color: AppColors.primary,
            elevation: 0,
            height: 38,
            minWidth: 100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Icon(
                  Icons.phone_outlined,
                  color: AppColors.white,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Text(
                  number,
                  style: AppTextStyle.mediumWhite12,
                ),
              ],
            ),
          ),
          const SizedBox(width: 30),
          MaterialButton(
            onPressed: messagePressed,
            color: AppColors.white,
            elevation: 6,
            height: 38,
            minWidth: 100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Icon(
                  Icons.message_outlined,
                  color: AppColors.black,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Text(
                  'Send Message',
                  style: AppTextStyle.mediumBlack12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
