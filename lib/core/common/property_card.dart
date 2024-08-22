import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/property/screens/property_details.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.exampleImage,
    required this.property,
    this.userProperty = false,
  });
  final Property property;
  final String exampleImage;
  final bool userProperty;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        decoration: const BoxDecoration(color: AppColors.lightGrey),
        // height: 180,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => PropertyDetails(
                          property: property,
                          userProperty: userProperty,
                        ));
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CachedNetworkImage(
                        height: 200,
                        width: double.infinity,
                        imageUrl: property.uploadImage![0].isNotEmpty
                            ? property.uploadImage![0]
                            : exampleImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Loader(),
                        errorWidget: (context, url, error) => const SizedBox(
                          width: double.infinity,
                          child: Icon(
                            Icons.error,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.bottomCenter,
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              spacing: 2,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.white,
                                  size: 18,
                                ),
                                Text(
                                  property.city,
                                  style: AppTextStyle.mediumWhite14,
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: 2,
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: AppColors.white,
                                  size: 18,
                                ),
                                Text(
                                  property.createdAt,
                                  style: AppTextStyle.mediumWhite14,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      property.otherType!.isNotEmpty
                          ? Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                color: AppColors.primary,
                                child: Text(
                                  property.otherType!,
                                  style: AppTextStyle.mediumWhite14,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                // const StackSmallWidget(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      property.title,
                      style: AppTextStyle.boldBlack20,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'AED ${property.price}',
                        style: AppTextStyle.boldBlack16
                            .copyWith(color: AppColors.primary),
                      ),
                      Wrap(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => PropertyDetails(
                                    property: property,
                                    userProperty: userProperty,
                                  ));
                            },
                            child: Text(
                              'DETAILS',
                              style: AppTextStyle.boldBlack14
                                  .copyWith(color: AppColors.primary),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: AppColors.primary,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            property.bedrooms!.isEmpty
                                ? 'Bedrooms : 0'
                                : 'Bedrooms : ${property.bedrooms}',
                            style: AppTextStyle.boldBlack16,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            property.bathrooms!.isEmpty
                                ? 'Bathrooms : 0'
                                : 'Bathrooms: ${property.bathrooms}',
                            style: AppTextStyle.boldBlack16,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
