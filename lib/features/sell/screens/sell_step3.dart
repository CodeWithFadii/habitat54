import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/sell/controllers/sell_controller.dart';
import 'package:habitat54/features/sell/widgets/previous_next_button.dart';
import 'package:habitat54/features/sell/widgets/sell_textfield.dart';

class SellStep3 extends StatelessWidget {
  const SellStep3({super.key, required this.sellC});
  final SellController sellC;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PreviousNextButton(
        previous: () {
          sellC.pageIndex(sellC.pageIndex.value - 1);
        },
        next: () {
          sellC.pageIndex(sellC.pageIndex.value + 1);
        },
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SellTextField(
                    label: 'Bedrooms',
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: SellTextField(
                    label: 'Bathrooms',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SellTextField(
              label: 'Property size (ft\u00b2)',
              keyboardType: TextInputType.number,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButton<String>(
                padding: EdgeInsets.only(right: 5),
                hint: Center(
                  child: const Text(
                    'Features',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                style: AppTextStyle.mediumBlack16,
                isExpanded:
                    true, // Make the dropdown button expand to full width
                dropdownColor: Colors.white,
                onChanged: (newValue) {},
                underline: SizedBox(),
                items: [
                  "Balcony",
                  "Basement Parking",
                  "Built-in Wardrobes",
                  "Furnished",
                  "Gym",
                  "Kids Play Area"
                ].map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(item),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8.0, // Adjust spacing between chips
                runSpacing: 2.0, // Adjust spacing between lines
                children: [
                  "Balcony",
                  "Basement Parking",
                  "Built-in Wardrobes",
                  "Furnished",
                  "Gym",
                  "Kids Play Area"
                ].map(
                  (e) {
                    return Chip(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.primary),
                      ),
                      backgroundColor: AppColors.primary,
                      label: Text(
                        e,
                        style: TextStyle(color: AppColors.white),
                      ),
                      deleteIcon: Icon(
                        Icons.clear,
                        size: 16,
                        color: AppColors.white,
                      ),
                      onDeleted: () {
                        // Handle chip deletion here
                      },
                    );
                  },
                ).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: TextField(
                cursorColor: AppColors.grey,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.add,
                    color: AppColors.black,
                  ),
                  labelText: 'Additional features',
                  labelStyle: const TextStyle(color: AppColors.grey),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
