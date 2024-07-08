import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/property/models/property.dart';

class DetailTileWidget extends StatelessWidget {
  const DetailTileWidget({
    super.key,
    required this.property,
  });

  final Property property;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0, // Adjust spacing between chips
              runSpacing: 5.0, // Adjust spacing between lines
              children: [
                Row(
                  children: [
                    Text(
                      'Property Type : ',
                      style: AppTextStyle.boldBlack16
                          .copyWith(color: AppColors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      property.propertyType,
                      style: AppTextStyle.boldBlack16,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                property.otherType!.isNotEmpty
                    ? Row(
                        children: [
                          Text(
                            'Offer Type : ',
                            style: AppTextStyle.boldBlack16
                                .copyWith(color: AppColors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            property.otherType ?? '',
                            style: AppTextStyle.boldBlack16,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )
                    : const SizedBox(),
                property.bedrooms!.isNotEmpty
                    ? Row(
                        children: [
                          Text(
                            'Bedrooms : ',
                            style: AppTextStyle.boldBlack16
                                .copyWith(color: AppColors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            property.bedrooms ?? '',
                            style: AppTextStyle.boldBlack16,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )
                    : const SizedBox(),
                property.bathrooms!.isNotEmpty
                    ? Row(
                        children: [
                          Text(
                            'Bathrooms : ',
                            style: AppTextStyle.boldBlack16
                                .copyWith(color: AppColors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            property.bathrooms ?? '',
                            style: AppTextStyle.boldBlack16,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )
                    : const SizedBox(),
                Row(
                  children: [
                    Text(
                      'City : ',
                      style: AppTextStyle.boldBlack16
                          .copyWith(color: AppColors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      property.city,
                      style: AppTextStyle.boldBlack16,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                property.nieghborhood!.isNotEmpty
                    ? Row(
                        children: [
                          Text(
                            'Nieghborhood : ',
                            style: AppTextStyle.boldBlack16
                                .copyWith(color: AppColors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            property.nieghborhood ?? '',
                            style: AppTextStyle.boldBlack16,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )
                    : const SizedBox(),
              ]),
        ],
      ),
    );
  }
}
