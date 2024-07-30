import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/contact_widget.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/utils.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/property/widgets/detail_tile_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendedDetailScreen extends StatelessWidget {
  const RecommendedDetailScreen(
      {super.key, this.userProperty = false, required this.property});
  final bool? userProperty;
  final Property property;
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

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
            actions: [
              userProperty!
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox()
            ],
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
              ExpansionTile(
                iconColor: AppColors.black,
                initiallyExpanded: true,
                shape: const Border(),
                title: Text(
                  'SELLER DETAILS',
                  style: AppTextStyle.boldBlack16
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                children: [
                  Text(
                    property.name,
                    style: AppTextStyle.boldBlack18
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    property.number ?? 'nill',
                    style: AppTextStyle.mediumBlack16,
                  ),
                  const SizedBox(height: 10),
                  property.number!.isNotEmpty
                      ? ContactWidget(
                          phonePressed: () {
                            launchUrl(Uri.parse("tel://${property.number}"));
                          },
                          messagePressed: () {
                            launchUrl(
                                Uri.parse("https://wa.me/${property.number}"));
                          },
                          number: property.number ?? '',
                        )
                      : const SizedBox(),
                ],
              ),
              featuresList.isEmpty
                  ? const SizedBox()
                  : ExpansionTile(
                      shape: const Border(),
                      title: Text(
                        'ADDIONAL FEATURES',
                        style: AppTextStyle.boldBlack16
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                shape: const Border(),
                initiallyExpanded: true,
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
                          property.title,
                          style: AppTextStyle.boldBlack18,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          property.description ?? '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
