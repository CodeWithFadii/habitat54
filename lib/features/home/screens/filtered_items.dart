import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/property_card.dart';
import 'package:habitat54/features/home/controllers/home_controller.dart';
import 'package:habitat54/features/home/widgets/property_filter_widget.dart';
import 'package:habitat54/features/property/models/property.dart';

class FilteredItems extends StatefulWidget {
  const FilteredItems({super.key, required this.propertyList});
  final List<Property> propertyList;

  @override
  State<FilteredItems> createState() => _FilteredItemsState();
}

class _FilteredItemsState extends State<FilteredItems> {
  final homeC = Get.find<HomeController>();
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';
  List<Property> filteredList = [];
  bool showFilterTile = false;

  @override
  void initState() {
    homeC.getFilteredItems(widget.propertyList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                offset: const Offset(5, 0),
              ),
            ],
          ),
          child: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              'Filtered Items',
              style: AppTextStyle.boldBlack18,
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'FILTERS',
                              style: AppTextStyle.boldBlack16
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showFilterTile = !showFilterTile;
                                });
                              },
                              child: Icon(showFilterTile
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down),
                            ),
                          ],
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: SizedBox(
                      height: showFilterTile
                          ? null
                          : 0, // Use height 0 when collapsed
                      child: PropertyFilterWidget(
                        showTitle: false,
                        homeC: homeC,
                        propertyList: widget.propertyList,
                        onApplyTap: () {
                          homeC.getFilteredItems(widget.propertyList);
                        },
                      ),
                    ),
                  ),
                  homeC.filteredList.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 50, bottom: 50),
                          child: Center(
                            child: Text('No Properties available'),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          itemCount: homeC.filteredList.length,
                          itemBuilder: (context, index) {
                            final property = homeC.filteredList[index];
                            return PropertyCard(
                              exampleImage: exampleImage,
                              property: property,
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
