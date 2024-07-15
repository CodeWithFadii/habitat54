import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/home/controllers/home_controller.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/sell/widgets/custom_dropdown.dart';

class PropertyFilterWidget extends StatelessWidget {
  const PropertyFilterWidget({
    super.key,
    required this.homeC,
    required this.propertyList,
    required this.onApplyTap,
    this.showTitle = true,
  });

  final HomeController homeC;

  final List<Property> propertyList;
  final VoidCallback onApplyTap;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showTitle
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FILTERS',
                          style: AppTextStyle.boldBlack16
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Divider()
                      ],
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Property Type',
                style: AppTextStyle.boldBlack16,
              ),
            ),
            CustomDropDown(
              title: 'Property Type',
              itemsList: const [
                'Apartment',
                'Villa',
                'Office',
                'Commercial Shop',
              ],
              onChanged: (value) {
                homeC.propertyType.value = value!;
              },
              value: homeC.propertyType.value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Offer Type',
                style: AppTextStyle.boldBlack16,
              ),
            ),
            CustomDropDown(
              title: 'Offer Type',
              itemsList: const ['For Rent', 'For Sale'],
              onChanged: (value) {
                homeC.offerType.value = value!;
              },
              value: homeC.offerType.value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Price',
                style: AppTextStyle.boldBlack16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: homeC.priceFrom,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.primary,
                      onTapOutside: (event) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'From',
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
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextField(
                      controller: homeC.priceTo,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.primary,
                      onTapOutside: (event) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'To',
                        hintStyle: AppTextStyle.regularBlack14.copyWith(
                            color: AppColors.grey,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'City',
                style: AppTextStyle.boldBlack16,
              ),
            ),
            CustomDropDown(
              title: 'City',
              itemsList: homeC.cityList.isNotEmpty
                  ? homeC.cityList
                  : [
                      "Abu Dhabi",
                      "Ajman",
                      "Dubai",
                      "Fujairah",
                      "Ras Al Khaimah",
                    ],
              onChanged: (value) {
                homeC.city.value = value!;
              },
              value: homeC.city.value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      homeC.clearFilter();
                    },
                    color: AppColors.white,
                    elevation: 6,
                    height: 38,
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Text(
                          'CLEAR',
                          style: AppTextStyle.mediumBlack12,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  MaterialButton(
                    onPressed: onApplyTap,
                    color: AppColors.primary,
                    elevation: 0,
                    height: 38,
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'APPLY',
                      style: AppTextStyle.mediumWhite12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
