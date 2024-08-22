import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/property/screens/property_details.dart';
import 'package:habitat54/features/property/screens/recommended_detail_screen.dart';

class FeatureProductCard extends StatelessWidget {
  const FeatureProductCard({
    super.key,
    required this.exampleImage,
    required this.property,
    this.comingFromFeatured = true,
  });

  final String exampleImage;
  final Property property;
  final bool? comingFromFeatured;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColors.lightGrey,
        ),
        width: 210,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () {
                    comingFromFeatured!
                        ? Get.to(() => PropertyDetails(property: property))
                        : Get.to(
                            () => RecommendedDetailScreen(property: property));
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: 160,
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: AppColors.primary),
                      child: Text(
                        'AED ${property.price}',
                        style: AppTextStyle.boldWhite16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  property.title,
                  style: AppTextStyle.mediumBlack16,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
