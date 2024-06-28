import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/feature_product_card.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/common/property_card.dart';
import 'package:habitat54/features/home/widgets/home_crousel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

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
              HomeCrousel(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Property Type',
                  style: AppTextStyle.boldBlack18,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration:
                    BoxDecoration(border: Border.all(color: AppColors.black)),
                child: DropdownButton<String>(
                  hint: Center(
                    child: const Text(
                      'Property Type',
                      style: TextStyle(
                          color: AppColors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                  style: AppTextStyle.mediumBlack16,
                  // value: 'Property Type', // Currently selected item
                  isExpanded:
                      true, // Make the dropdown button expand to full width
                  dropdownColor: Colors.white,

                  onChanged: (newValue) {},
                  underline: SizedBox(),

                  items: ['Apartment', 'Villa', 'Office', 'Commercial Shop']
                      .map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(item),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Offer Type',
                  style: AppTextStyle.boldBlack18,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration:
                    BoxDecoration(border: Border.all(color: AppColors.black)),
                child: DropdownButton<String>(
                  hint: Center(
                    child: const Text(
                      'Offer Type',
                      style: TextStyle(
                          color: AppColors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                  style: AppTextStyle.mediumBlack16,
                  // value: 'Property Type', // Currently selected item
                  isExpanded:
                      true, // Make the dropdown button expand to full width
                  dropdownColor: Colors.white,

                  onChanged: (newValue) {},
                  underline: SizedBox(),

                  items: ['For Rent', 'For Sale'].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(item),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Price',
                  style: AppTextStyle.boldBlack18,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: AppColors.primary,
                        onTapOutside: (event) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'From',
                          hintStyle: AppTextStyle.regularBlack14.copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: AppColors.primary,
                        onTapOutside: (event) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'To',
                          hintStyle: AppTextStyle.regularBlack14.copyWith(
                              color: AppColors.grey,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'City',
                  style: AppTextStyle.boldBlack18,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration:
                    BoxDecoration(border: Border.all(color: AppColors.black)),
                child: DropdownButton<String>(
                  hint: Center(
                    child: const Text(
                      'City',
                      style: TextStyle(
                          color: AppColors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                  style: AppTextStyle.mediumBlack16,
                  // value: 'Property Type', // Currently selected item
                  isExpanded:
                      true, // Make the dropdown button expand to full width
                  dropdownColor: Colors.white,

                  onChanged: (newValue) {},
                  underline: SizedBox(),

                  items: [
                    "Abu Dhabi",
                    "Ajman",
                    "Dubai",
                    "Fujairah",
                    "Ras Al Khaimah",
                    "Sharjah",
                    "Umm Al Quwain"
                  ].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(item),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        // Get.offAll(() => LoginScreen());
                      },
                      color: AppColors.white,
                      elevation: 6,
                      height: 38,
                      minWidth: 100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text(
                            'CLEAR',
                            style: AppTextStyle.mediumBlack12,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    MaterialButton(
                      onPressed: () {
                        // Get.offAll(() => LoginScreen());
                      },
                      color: AppColors.primary,
                      elevation: 0,
                      height: 38,
                      minWidth: 100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'APPLY',
                        style: AppTextStyle.mediumWhite12,
                      ),
                    ),
                  ],
                ),
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
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'FEATURED',
                      style: AppTextStyle.boldBlack16
                          .copyWith(fontWeight: FontWeight.bold),
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
            ],
          ),
        ),
      ),
    );
  }
}
