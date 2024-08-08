import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/home/controllers/home_controller.dart';
import 'package:habitat54/features/home/widgets/short_textfield.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/sell/widgets/custom_dropdown.dart';

class PropertyFilterWidget extends StatelessWidget {
  const PropertyFilterWidget({
    super.key,
    required this.homeC,
    required this.propertyList,
    required this.onApplyTap,
    this.showTitle = true,
    this.showAdvanceFilter = true,
  });

  final HomeController homeC;
  final List<Property> propertyList;
  final VoidCallback onApplyTap;
  final bool showTitle;
  final bool showAdvanceFilter;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showTitle
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                  ShortTextField(
                    controller: homeC.priceFrom,
                    hint: 'From',
                  ),
                  const SizedBox(width: 30),
                  ShortTextField(
                    controller: homeC.priceTo,
                    hint: 'To',
                  )
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
            showAdvanceFilter
                ? ExpansionTile(
                    iconColor: AppColors.black,
                    shape: const Border(),
                    title: Text(
                      'Additional Filters',
                      style: AppTextStyle.boldBlack16,
                    ),
                    tilePadding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Neighborhood',
                              style: AppTextStyle.boldBlack16,
                            ),
                          ),
                          CustomDropDown(
                            title: 'Neighborhood',
                            itemsList: homeC.neighborhoodList.isNotEmpty
                                ? homeC.neighborhoodList
                                : [
                                    'Al Zahiyah',
                                    'Khalifa City',
                                    'Downtown Dubai',
                                    'Dubai Marina',
                                    'Al Taawun',
                                    'Abu Shagara',
                                  ],
                            onChanged: (value) {
                              homeC.neighborhood.value = value!;
                            },
                            value: homeC.neighborhood.value,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Bedrooms',
                              style: AppTextStyle.boldBlack16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Row(
                              children: [
                                ShortTextField(
                                  controller: homeC.bedroomsFrom,
                                  hint: 'From',
                                ),
                                const SizedBox(width: 30),
                                ShortTextField(
                                  controller: homeC.bedroomsTo,
                                  hint: 'To',
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Bathrooms',
                              style: AppTextStyle.boldBlack16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Row(
                              children: [
                                ShortTextField(
                                  controller: homeC.bathroomsFrom,
                                  hint: 'From',
                                ),
                                const SizedBox(width: 30),
                                ShortTextField(
                                  controller: homeC.bathroomsTo,
                                  hint: 'To',
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Property size (ft\u00b2)',
                              style: AppTextStyle.boldBlack16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Row(
                              children: [
                                ShortTextField(
                                  controller: homeC.propertySizeFrom,
                                  hint: 'From',
                                ),
                                const SizedBox(width: 30),
                                ShortTextField(
                                  controller: homeC.propertySizeTo,
                                  hint: 'To',
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Features',
                              style: AppTextStyle.boldBlack16,
                            ),
                          ),
                          CustomDropDown(
                            title: 'Features',
                            itemsList: const [
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
                            ],
                            onChanged: (value) {
                              if (!homeC.featuresList.contains(value)) {
                                homeC.featuresList.add(value!);
                              }
                            },
                            value: homeC.propertyType.value,
                          ),
                          Obx(
                            () => Padding(
                              padding: homeC.featuresList.isNotEmpty
                                  ? const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15)
                                  : const EdgeInsets.all(0),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 8.0, // Adjust spacing between chips
                                runSpacing: 2.0, // Adjust spacing between lines
                                children: homeC.featuresList.map(
                                  (feature) {
                                    return Chip(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: AppColors.primary),
                                      ),
                                      backgroundColor: AppColors.primary,
                                      label: Text(
                                        feature,
                                        style: const TextStyle(
                                            color: AppColors.white),
                                      ),
                                      deleteIcon: const Icon(
                                        Icons.clear,
                                        size: 16,
                                        color: AppColors.white,
                                      ),
                                      onDeleted: () {
                                        homeC.featuresList.remove(feature);
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
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
