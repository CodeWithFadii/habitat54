import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/contact_widget.dart';
import 'package:habitat54/core/common/feature_product_card.dart';
import 'package:habitat54/core/utils.dart';
// ignore: library_prefixes
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/home/controllers/home_controller.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/property/widgets/detail_tile_widget.dart';

class PropertyDetails extends StatelessWidget {
  PropertyDetails(
      {super.key, this.userProperty = false, required this.property});
  final bool? userProperty;
  final Property property;

  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final featuresList = parseDataString(property);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.7), // Shadow color
                spreadRadius: 0.1, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(5,
                    0), // Offset in the vertical direction (negative for top shadow)
              ),
            ],
          ),
          child: AppBar(
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: Text(
              property.propertyType,
              style: AppTextStyle.boldBlack18,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 230,
                child: PageView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CachedNetworkImage(
                          width: double.infinity,
                          height: 230,
                          imageUrl: property.uploadImage!.isNotEmpty
                              ? property.uploadImage!
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
                        // StackSmallWidget(
                        //   widget: Text(
                        //     '1/4',
                        //     style: AppTextStyle.mediumWhite16,
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              alignment: Alignment.center,
                              height: 40,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: AppColors.primary),
                              child: Text(
                                'AED ${property.price}',
                                style: AppTextStyle.boldWhite16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              DetailTileWidget(property: property),
              ContactWidget(
                phonePressed: () {
                  UrlLauncher.launchUrl(Uri.parse("tel://${property.number}"));
                },
                messagePressed: () {
                  UrlLauncher.launchUrl(
                      Uri.parse("https://wa.me/${property.number}"));
                },
                number: property.number ?? '',
              ),
              featuresList.isEmpty
                  ? const SizedBox()
                  : ExpansionTile(
                      iconColor: AppColors.black,
                      shape: const Border(),
                      title: Text(
                        'ADDITIONAL FEATURES',
                        style: AppTextStyle.boldBlack16
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: featuresList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 40, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    featuresList[index],
                                    style: AppTextStyle.regularBlack16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Checkbox(
                                  value: true,
                                  onChanged: (_) {},
                                  activeColor: AppColors.primary,
                                )
                              ],
                            );
                          },
                        )
                      ],
                    ),
              ExpansionTile(
                iconColor: AppColors.black,
                initiallyExpanded: true,
                shape: const Border(),
                title: Text(
                  'SELLER COMMENTS',
                  style: AppTextStyle.boldBlack16
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title.capitalizeFirst!,
                          style: AppTextStyle.boldBlack18,
                        ),
                        const SizedBox(height: 10),
                        property.description == ''
                            ? const SizedBox(height: 10)
                            : const SizedBox(),
                        Text(
                          property.description ?? '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 20),
              //       child: Text(
              //         'SELLER COMMENTS',
              //         style: AppTextStyle.boldBlack16
              //             .copyWith(fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       alignment: Alignment.topLeft,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             property.title.capitalizeFirst!,
              //             style: AppTextStyle.boldBlack18,
              //           ),
              //           property.description == ''
              //               ? const SizedBox(height: 10)
              //               : const SizedBox(),
              //           Text(
              //             property.description ?? '',
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RECOMMENDED',
                      style: AppTextStyle.boldBlack16
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 256,
                child: FutureBuilder<List<Property>>(
                  future: homeC.getProperties(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Loader()
                        : snapshot.hasError
                            ? const Center(
                                child: Text(
                                    '  Something went wrong, Please check your internet connection before try again'),
                              )
                            : snapshot.data!.isEmpty
                                ? const Center(
                                    child: Text('No data available'),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    itemCount: snapshot.data!.length > 5
                                        ? 5
                                        : snapshot.data!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final propertyList =
                                          snapshot.data!.reversed.toList();
                                      return FeatureProductCard(
                                        exampleImage: exampleImage,
                                        property: propertyList[index],
                                        comingFromFeatured: false,
                                      );
                                    },
                                  );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
