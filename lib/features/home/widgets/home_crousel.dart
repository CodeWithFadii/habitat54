import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';

class HomeCrousel extends StatelessWidget {
  HomeCrousel({
    super.key,
  });
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: PageView.builder(
        itemCount: 5,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CachedNetworkImage(
                width: double.infinity,
                height: 380,
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
                margin: EdgeInsets.only(bottom: 20, left: 40, right: 40),
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                alignment: Alignment.center,
                height: 80,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: AppColors.white),
                child: Text(
                  '2 bedroom apartment for sale in downtown dubai'
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: AppTextStyle.boldBlack18
                      .copyWith(fontWeight: FontWeight.bold),
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
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeOutExpo);
                          },
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.6)),
                            child: Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeOutExpo);
                          },
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.6)),
                            child: Icon(Icons.arrow_forward_ios),
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
