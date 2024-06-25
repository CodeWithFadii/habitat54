import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.exampleImage,
  });

  final String exampleImage;

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
                CachedNetworkImage(
                  height: 165,
                  width: double.infinity,
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
                Container(
                  margin: const EdgeInsets.all(10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                  width: 40,
                  decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.white,
                        size: 17,
                      ),
                      Text(
                        '5',
                        style: AppTextStyle.boldWhite12
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    '2 bedroom apartment for sale in Downtown Dubai',
                    style: AppTextStyle.boldBlack20,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'AED 49,999',
                        style: AppTextStyle.boldBlack16
                            .copyWith(color: AppColors.primary),
                      ),
                      Wrap(
                        children: [
                          Text(
                            'DETAILS',
                            style: AppTextStyle.boldBlack14
                                .copyWith(color: AppColors.primary),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
