import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';

class SellTextField extends StatelessWidget {
  const SellTextField({
    super.key,
    this.maxLines = 1,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.error = false,
  });

  final int maxLines;
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
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
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: error! ? AppColors.primary : AppColors.black),
              ),
            ),
          ),
          error!
              ? const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'This field is required',
                    style: TextStyle(color: AppColors.primary),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
