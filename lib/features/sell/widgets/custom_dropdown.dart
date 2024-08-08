import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.title,
    required this.itemsList,
    required this.onChanged,
    this.error = false,
    required this.value,
  });
  final String title;
  final String value;
  final List<String> itemsList;
  final Function(String?) onChanged;
  final bool? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(
                  color: error! ? AppColors.primary : AppColors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton<String>(
              hint: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: AppColors.grey, fontStyle: FontStyle.italic),
                ),
              ),
              style: AppTextStyle.regularBlack16,
              value: value.isNotEmpty ? value : null, // Currently selected item
              isExpanded: true, // Make the dropdown button expand to full width
              dropdownColor: Colors.white,
              iconDisabledColor: AppColors.black,

              onChanged: onChanged,
              underline: const SizedBox(),
              items: itemsList.map(
                (String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(item),
                    ),
                  );
                },
              ).toList(),
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
              : const SizedBox()
        ],
      ),
    );
  }
}
