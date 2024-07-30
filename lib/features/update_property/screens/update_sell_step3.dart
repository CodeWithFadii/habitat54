import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/sell/widgets/previous_next_button.dart';
import 'package:habitat54/features/sell/widgets/sell_textfield.dart';
import 'package:habitat54/features/update_property/controllers/update_sell_controller.dart';

class UpdateSellStep3 extends StatelessWidget {
   UpdateSellStep3({super.key});

  final sellC = Get.find<UpdateSellController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PreviousNextButton(
        previous: () {
          sellC.pageIndex(sellC.pageIndex.value - 1);
        },
        next: () {
          sellC.step3Validator();
        },
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: SellTextField(
                      controller: sellC.bedroomsC,
                      label: 'Bedrooms',
                      keyboardType: TextInputType.number,
                      error: sellC.step3Validate.value
                          ? sellC.bedroomsC.text.isNotEmpty
                              ? false
                              : true
                          : false,
                    ),
                  ),
                  Expanded(
                    child: SellTextField(
                      controller: sellC.bathroomsC,
                      label: 'Bathrooms',
                      keyboardType: TextInputType.number,
                      error: sellC.step3Validate.value
                          ? sellC.bathroomsC.text.isNotEmpty
                              ? false
                              : true
                          : false,
                    ),
                  ),
                ],
              );
            }),
            SellTextField(
              controller: sellC.propertySize,
              label: 'Property size (ft\u00b2)',
              keyboardType: TextInputType.number,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButton<String>(
                padding: const EdgeInsets.only(right: 5),
                hint: const Center(
                  child: Text(
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
                onChanged: (feature) {
                  sellC.addFeature(feature!);
                },
                underline: const SizedBox(),
                items: [
                  "Balcony",
                  "Basement Parking",
                  "Built-in Wardrobes",
                  "Furnished",
                  "Gym",
                  "Kids Play Area",
                  "Private Garden",
                  "Security",
                  "Semi Furnished",
                  "Swimming Pool",
                  "Unfurnished"
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
            Obx(
              () => Padding(
                padding: sellC.featuresList.isNotEmpty
                    ? const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                    : const EdgeInsets.all(0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.0, // Adjust spacing between chips
                  runSpacing: 2.0, // Adjust spacing between lines
                  children: sellC.featuresList.map(
                    (feature) {
                      return Chip(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.primary),
                        ),
                        backgroundColor: AppColors.primary,
                        label: Text(
                          feature,
                          style: const TextStyle(color: AppColors.white),
                        ),
                        deleteIcon: const Icon(
                          Icons.clear,
                          size: 16,
                          color: AppColors.white,
                        ),
                        onDeleted: () {
                          sellC.removeFeature(feature);
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
