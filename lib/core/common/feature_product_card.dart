import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';

class FeatureProductCard extends StatelessWidget {
  const FeatureProductCard({
    super.key,
    required this.exampleImage,
  });

  final String exampleImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        margin: EdgeInsets.only(left: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColors.lightGrey,
        ),
        width: 210,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: 160,
                    imageUrl: exampleImage,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: AppColors.primary),
                      child: Text(
                        'AED 49,000',
                        style: AppTextStyle.boldWhite16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                '2 bedroom apertment for sale in downtown dubai',
                style: AppTextStyle.mediumBlack16,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
