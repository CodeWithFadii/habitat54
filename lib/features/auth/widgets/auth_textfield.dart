import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.text,
    this.trailing,
    this.controller,
    this.obscureText = false,
    this.trailingTap,
    this.readOnly = false,
    this.validator,
    this.formKey,
    required this.leadingIcon, this.keyboardType,
  });
  final String text;
  final IconData? trailing;
  final GlobalKey<FormState>? formKey;

  final String? Function(String?)? validator;
    final VoidCallback? trailingTap;
  final bool? obscureText;
  final TextEditingController? controller;
  final bool readOnly;
  final IconData leadingIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 10),
            child: Icon(
              leadingIcon,
              size: 30,
              color: AppColors.grey,
            ),
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: TextFormField(
                keyboardType:keyboardType ?? TextInputType.text,
                obscureText: obscureText!,
                validator: validator,
                controller: controller,
                readOnly: readOnly,
                cursorColor: AppColors.grey,
                style: AppTextStyle.regularBlack18,
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  errorStyle: AppTextStyle.mediumBlack12
                      .copyWith(color: AppColors.primary),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  // prefixIcon: Icon(
                  //   leadingIcon,
                  //   color: AppColors.grey,
                  // ),
                  suffixIcon: GestureDetector(
                      onTap: trailingTap,
                      child: Icon(
                        trailing,
                        color: AppColors.grey,
                      )),
                  labelText: text,
                  labelStyle: AppTextStyle.regularWhite16
                      .copyWith(color: AppColors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
