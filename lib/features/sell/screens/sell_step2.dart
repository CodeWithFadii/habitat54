import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/sell/controllers/sell_controller.dart';
import 'package:habitat54/features/sell/widgets/previous_next_button.dart';

class SellStep2 extends StatelessWidget {
  const SellStep2({super.key, required this.sellC});
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
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Show Map',
                  style: TextStyle(color: AppColors.white),
                ),
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
                      'City',
                      style: TextStyle(
                          color: AppColors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                  style: AppTextStyle.mediumBlack16,
                  // value: 'Property Type', // Currently selected item
                  isExpanded:
                      true, // Make the dropdown button expand to full width
                  dropdownColor: Colors.white,
                  onChanged: (newValue) {},
                  underline: SizedBox(),
                  items: ['Abu Dhabi', 'Sharjah', 'Dubai', 'Ajman']
                      .map((String item) {
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
                      'Neighborhood',
                      style: TextStyle(
                          color: AppColors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                  style: AppTextStyle.mediumBlack16,
                  // value: 'Property Type', // Currently selected item
                  isExpanded:
                      true, // Make the dropdown button expand to full width
                  dropdownColor: Colors.white,
                  onChanged: (newValue) {},
                  underline: SizedBox(),
                  items: [
                    "Downtown Dubai",
                    "Dubai Marina",
                    "Jumeirah",
                    "Deira",
                    "Business Bay"
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
            ],
          ),
        ),
      ),
    );
  }
}
