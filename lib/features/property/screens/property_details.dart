import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/back_button_widget.dart';
import 'package:habitat54/core/common/feature_product_card.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/common/stack_small_widget.dart';
import 'package:habitat54/features/property/widgets/detail_tile_widget.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({super.key});

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

  bool showComment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
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
            centerTitle: true,
            title: Text(
              'Apartment',
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
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CachedNetworkImage(
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
                        StackSmallWidget(
                          widget: Text(
                            '1/4',
                            style: AppTextStyle.mediumWhite16,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 100,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: AppColors.primary),
                              child: Text(
                                'AED 49,000',
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
              const Column(
                children: [
                  DetailTileWidget(
                    title1: 'Bedrooms',
                    value1: '2',
                    title2: 'Bathrooms',
                    value2: '2',
                  ),
                  DetailTileWidget(
                    title1: 'Offer Type',
                    value1: 'For Sale',
                    title2: 'City',
                    value2: 'Dubai',
                  ),
                  DetailTileWidget(
                    title1: 'Neighborhood',
                    value1: 'Downtown Dubai',
                  ),
                  DetailTileWidget(
                    title1: 'Property Type',
                    value1: 'Apartment',
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SELLER COMMENTS',
                          style: AppTextStyle.boldBlack16,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showComment
                                  ? showComment = !showComment
                                  : showComment = true;
                            });
                          },
                          child: Icon(
                            showComment
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
              Visibility(
                visible: showComment,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2 BEDROOM APARTMENT FOR SALE IN DOWNTOWN DUBAI',
                        style: AppTextStyle.boldBlack18,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '2 bedroom apartment for sale in downtown dubai',
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'RECOMMENDED',
                          style: AppTextStyle.boldBlack16,
                        ),
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
              SizedBox(
                height: 256,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return FeatureProductCard(exampleImage: exampleImage);
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
