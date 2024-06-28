import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';

class SellTextField extends StatelessWidget {
  const SellTextField({
    super.key,
    this.maxLines = 1,
    required this.label,
    this.keyboardType = TextInputType.text,
  });

  final int maxLines;
  final String label;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: TextField(
        keyboardType: keyboardType,
        maxLines: maxLines,
        cursorColor: AppColors.grey,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.grey),
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
