import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/features/dashboard/dashboard.dart';
import 'package:habitat54/features/profile/screens/my_properties_screen.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:http/http.dart' as http;
import 'package:habitat54/features/home/screens/filtered_items.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<String> cityList = <String>[].obs;
  RxList<Property> filteredList = <Property>[].obs;
  RxString propertyType = ''.obs;
  RxString offerType = ''.obs;
  RxString city = ''.obs;
  TextEditingController priceFrom = TextEditingController();
  TextEditingController priceTo = TextEditingController();

  Future<List<Property>> getProperties() async {
    try {
      List<Property> propertyList = [];
      final url = Uri.parse('${AppConstants.baseUrl}allproducts');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var i in data['allproducts']) {
          try {
            propertyList.add(
              Property.fromJson(i),
            );
          } catch (e) {
            log('Error converting JSON to Property: $e');
            // Skip this item and continue with the next
            continue;
          }
        }
        return propertyList; // Return the list if successful
      } else {
        // Handle other status codes or errors
        log('Error: ${response.statusCode}');
        throw Exception('Failed to load properties');
      }
    } catch (e) {
      throw Exception('Failed to fetch properties: $e');
    }
  }

  void deleteProperty(int propertyId) async {
    final url = Uri.parse('${AppConstants.baseUrl}delete_products/$propertyId');
    isLoading(true);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Get.offAll(() => DashBoard(
            index: 3,
          ));
      isLoading(false);
      final data = json.decode(response.body);
      Get.to(() => const MyPropertiesScreen(isRefresh: true));
      log(data['message']);
    } else {
      isLoading(false);
      log(response.statusCode.toString());
    }
    isLoading(false);
  }

  void clearFilter() {
    propertyType.value = '';
    offerType.value = '';
    city.value = '';
    priceFrom.clear();
    priceTo.clear();
  }

  void navigateToFilterScreen(propertyList) {
    if (propertyType.isNotEmpty ||
        offerType.isNotEmpty ||
        priceFrom.text.isNotEmpty ||
        priceTo.text.isNotEmpty ||
        city.isNotEmpty) {
      Get.to(() => FilteredItems(
            propertyList: propertyList,
          ));
    }
  }

  Future<void> fetchCity() async {
    final url = Uri.parse('https://app.webaotoolkit.com/api/city');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse JSON
        final data = jsonDecode(response.body);

        // Extract names and cast to List<String>
        List<dynamic> cityData = data['city'];
        List<String> names =
            cityData.map((city) => city['name'].toString()).toList();

        // Update state with names
        cityList.addAll(names);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  void getFilteredItems(List<Property> propertyList) {
    filteredList.value = propertyList;

    if (propertyType.value.isNotEmpty) {
      filteredList.value = filteredList.where((data) {
        return data.propertyType == propertyType.value;
      }).toList();
    }
    if (offerType.value.isNotEmpty) {
      filteredList.value = filteredList.where((data) {
        return data.otherType == offerType.value;
      }).toList();
    }
    if (priceFrom.text.isNotEmpty) {
      filteredList.value = filteredList.where((data) {
        return int.parse(data.price) > int.parse(priceFrom.text);
      }).toList();
    }
    if (priceTo.text.isNotEmpty) {
      filteredList.value = filteredList.where((data) {
        return int.parse(data.price) < int.parse(priceTo.text);
      }).toList();
    }
    if (city.value.isNotEmpty) {
      filteredList.value = filteredList.where((data) {
        return data.city == city.value;
      }).toList();
    }
  }

  @override
  void onInit() {
    fetchCity();
    // getProperties();
    super.onInit();
  }
}
