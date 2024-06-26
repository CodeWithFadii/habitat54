import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/feature_product_card.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/common/property_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
                          margin:
                              EdgeInsets.only(bottom: 20, left: 40, right: 40),
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                          alignment: Alignment.center,
                          height: 80,
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.white),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _pageController.previousPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.white.withOpacity(0.6)),
                                      child: Icon(Icons.arrow_back_ios),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _pageController.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.white.withOpacity(0.6)),
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
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Property Type',
                    style: AppTextStyle.boldBlack18,
                  )
                ],
              ),
              DropdownButton<String>(
                
                hint: const Text('Property Type'), // Hint text
                // value: 'Property Type', // Currently selected item
                isExpanded:
                    true, // Make the dropdown button expand to full width
                dropdownColor: Colors.white,
                onChanged: (newValue) {},
                items: ['Apartment', 'Villa', 'Office', 'Commercial Shop']
                    .map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'RECENTLY ADDED',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 20),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return PropertyCard(exampleImage: exampleImage);
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                color: AppColors.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'FEATURED',
                      style: AppTextStyle.boldWhite16,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 256,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return FeatureProductCard(exampleImage: exampleImage);
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  alignment: Alignment.center,
                  height: 50,
                  width: 100,
                  color: AppColors.primary,
                  child: Text(
                    'View more',
                    style: AppTextStyle.boldWhite16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
