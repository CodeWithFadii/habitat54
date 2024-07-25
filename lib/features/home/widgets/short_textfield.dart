
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class ShortTextField extends StatelessWidget {
  const ShortTextField({
    super.key,
    required this.hint,
    required this.controller,
  });

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        cursorColor: AppColors.primary,
        onTapOutside: (event) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyle.regularBlack14.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
