import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/constants/app_constants.dart';

class HomeCrousel extends StatefulWidget {
  const HomeCrousel({super.key});

  @override
  _HomeCrouselState createState() => _HomeCrouselState();
}

class _HomeCrouselState extends State<HomeCrousel> {
  final PageController _pageController = PageController();
  late Timer _timer;
  bool _isReversed = false;
  int _currentPage = 0;
  List<String> propertyAdvertisements = [
    "Modern Shops in Prime Locations",
    "Luxury Living, Affordable Prices Await",
    "Spacious Apartments, Stunning City Views"
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_isReversed) {
        if (_currentPage == 0) {
          _isReversed = false;
          _currentPage++;
        } else {
          _currentPage--;
        }
      } else {
        if (_currentPage == AppConstants.bannerList.length - 1) {
          _isReversed = true;
          _currentPage--;
        } else {
          _currentPage++;
        }
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: PageView.builder(
        itemCount: AppConstants.bannerList.length,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final image = AppConstants.bannerList[index];
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                child: Image.asset(
                  image,
                  height: 380,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 380,
                width: double.infinity,
                color: AppColors.black.withOpacity(0.25),
                child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 1000),
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: value * 145),
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    propertyAdvertisements[index],
                    style: AppTextStyle.boldWhite30
                        .copyWith(fontWeight: FontWeight.w900, wordSpacing: 1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
