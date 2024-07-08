import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/property/screens/property_details.dart';

class HomeCrousel extends StatelessWidget {
  HomeCrousel({
    super.key,
    required this.propertyList,
  });
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

  final List<Property> propertyList;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: PageView.builder(
        itemCount: propertyList.length > 5 ? 5 : propertyList.length,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => PropertyDetails(property: propertyList[index]));
                },
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 380,
                  imageUrl: propertyList[index].uploadImage!,
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
              Positioned(
                left: 40,
                right: 40,
                bottom: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.white,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      propertyList[index].title.toUpperCase(),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow
                          .ellipsis, // optional: adds ellipsis if text overflows
                      style: AppTextStyle.boldBlack18
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutExpo);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.6)),
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutExpo);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.6)),
                            child: const Icon(Icons.arrow_forward_ios),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
