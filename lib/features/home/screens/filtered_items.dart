import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/property_card.dart';
import 'package:habitat54/features/home/controllers/home_controller.dart';
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

  void getFilteredItems() {
    filteredList = widget.propertyList;

    if (homeC.propertyType.value.isNotEmpty) {
      filteredList = filteredList.where((data) {
        return data.propertyType == homeC.propertyType.value;
      }).toList();
    }
    if (homeC.offerType.value.isNotEmpty) {
      filteredList = filteredList.where((data) {
        return data.otherType == homeC.offerType.value;
      }).toList();
    }
    if (homeC.priceFrom.text.isNotEmpty) {
      filteredList = filteredList.where((data) {
        return int.parse(data.price) > int.parse(homeC.priceFrom.text);
      }).toList();
    }
    if (homeC.priceTo.text.isNotEmpty) {
      filteredList = filteredList.where((data) {
        return int.parse(data.price) < int.parse(homeC.priceTo.text);
      }).toList();
    }
    if (homeC.city.value.isNotEmpty) {
      filteredList = filteredList.where((data) {
        return data.city == homeC.city.value;
      }).toList();
    }

    setState(() {}); // Update UI after filtering
  }

  @override
  void initState() {
    getFilteredItems();
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
      body: SafeArea(
        child: filteredList.isEmpty
            ? const Center(
                child: Text('No data available'),
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final property = filteredList[index];
                  return PropertyCard(
                    exampleImage: exampleImage,
                    property: property,
                  );
                },
              ),
      ),
    );
  }
}
