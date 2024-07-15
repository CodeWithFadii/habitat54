import 'dart:convert';
import 'dart:developer';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/core/utils.dart';
import 'package:habitat54/features/profile/controllers/profile_controller.dart';
import 'package:habitat54/features/profile/screens/my_properties_screen.dart';
import 'package:habitat54/features/update_property/screens/update_sell_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/sell/screens/sell_step4.dart';

class UpdateSellController extends GetxController {
  RxString propertyId = ''.obs;
  RxBool isLoading = false.obs;
  RxInt pageIndex = 0.obs;
  RxList<String> imagesList = <String>[].obs;
  RxString galleryImage = ''.obs;
  RxString galleryDocument = ''.obs;
  RxString document = ''.obs;
  RxList<String> featuresList = <String>[].obs;
  RxList<String> cityList = <String>[].obs;
  RxList<String> neighborhoodList = <String>[].obs;

  RxList<AdditionalFeature> additionalFeaturesList = <AdditionalFeature>[].obs;
  //DropDownItems
  RxString propertyType = ''.obs;
  RxString offerType = ''.obs;
  RxString city = ''.obs;
  RxString neighborhood = ''.obs;
  //Validators
  RxBool step1Validate = false.obs;
  RxBool step2Validate = false.obs;
  //TextEditingControllers
  TextEditingController titleC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController bedroomsC = TextEditingController();
  TextEditingController bathroomsC = TextEditingController();
  TextEditingController propertySize = TextEditingController();
  TextEditingController featureC = TextEditingController();
  TextEditingController youtubeLink = TextEditingController();
  TextEditingController additionalFeatureNameC = TextEditingController();
  TextEditingController additionalFeatureValueC = TextEditingController();
  final profileC = Get.find<ProfileController>();

  Future<void> uploadProperty() async {
    final url =
        Uri.parse('${AppConstants.baseUrl}update_products/${propertyId.value}');

    try {
      // Create multipart request
      isLoading(true);
      final request = http.MultipartRequest('POST', url);

      // Add fields to the request

      request.fields['user_id'] = profileC.user.value!.id.toString();
      request.fields['name'] = profileC.user.value?.name ?? "";
      request.fields['number'] = profileC.user.value?.number ?? "";
      request.fields['title'] = titleC.text.toString();
      request.fields['description'] = descriptionC.text.toString();
      request.fields['price'] = priceC.text.toString();
      request.fields['property_type'] = propertyType.value.toString();
      request.fields['Other_type'] = offerType.value.toString();
      request.fields['city'] = city.value.toString();
      request.fields['property_size'] = propertySize.text.toString();
      request.fields['nieghborhood'] = neighborhood.value.toString();
      request.fields['bedrooms'] = bedroomsC.text.toString();
      request.fields['bathrooms'] = bathroomsC.text.toString();
      request.fields['vedio'] = youtubeLink.text.toString();
      request.fields['features'] =
          jsonEncode(featuresList.map((feature) => feature).toList());

      // Convert additionalFeaturesList to List<Map<String, dynamic>>
      List<Map<String, dynamic>> additionalDataJson =
          additionalFeaturesList.map((feature) => feature.toJson()).toList();
      request.fields['additional_data'] = jsonEncode(additionalDataJson);

      // Convert additionalDataJson to JSON string and add to request

      // Add image file if exists
      if (imagesList.isEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'upload_image', galleryImage.value.toString()));
      }
      if (document.value.isEmpty && galleryDocument.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'upload_document', galleryDocument.value.toString()));
      }

      // Define headers
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      // Send the request
      final response = await request.send();
      isLoading(false);
      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 500) {
        clearValues();
        Get.off(() => const MyPropertiesScreen(isRefresh: true));
        showCustomSnackbar('Product Updated');
        isLoading(false);
      } else {
        
        // final responseBody = await response.stream.bytesToString();
        log('HTTP Error: ${response.statusCode}');
        isLoading(false);
        showCustomSnackbar('Something went wrong please try again');
      }
    } catch (e) {
      log('Exception: $e');
      isLoading(false);
    }
  }

  void clearValues() {
    pageIndex.value = 0;
    propertyId.value = '';
    imagesList.clear();
    galleryImage.value = '';
    document.value = '';
    galleryDocument.value = '';
    featuresList.clear();
    additionalFeaturesList.clear();
    propertyType.value = '';
    offerType.value = '';
    city.value = '';
    neighborhood.value = '';
    step1Validate.value = false;
    step2Validate.value = false;
    titleC.clear();
    descriptionC.clear();
    priceC.clear();
    bedroomsC.clear();
    bathroomsC.clear();
    propertySize.clear();
    featureC.clear();
    youtubeLink.clear();
    additionalFeatureNameC.clear();
    additionalFeatureValueC.clear();
  }

  void updatePropertyValues(Property property, List<String> features) {
    pageIndex.value = 0;
    propertyId.value = property.id.toString();
    imagesList.clear();
    imagesList.add(property.uploadImage!);
    document.value = property.uploadDocument ?? '';
    featuresList.clear();
    featuresList.addAll(features);
    // additionalFeaturesList.clear();
    propertyType.value = property.propertyType;
    offerType.value = property.otherType ?? '';
    city.value = property.city;
    neighborhood.value = property.nieghborhood ?? '';
    step1Validate.value = false;
    step2Validate.value = false;
    titleC.text = property.title;
    descriptionC.text = property.description ?? '';
    priceC.text = property.price;
    bedroomsC.text = property.bedrooms ?? '';
    bathroomsC.text = property.bathrooms ?? '';
    propertySize.text = property.propertySize ?? '';
    featureC.clear();
    youtubeLink.text = property.vedio ?? '';
    // additionalFeaturesList.value = property.additional;
    additionalFeatureNameC.clear();
    additionalFeatureValueC.clear();
    Get.to(() => const UpdateSellScreen());
  }

  Future<void> getImagesFromGallery() async {
    final pic = await pickImage();
    if (pic != null) {
      imagesList.clear();
      galleryImage.value = pic.path;
    }
  }

  Future<void> getDocument() async {
    final pic = await pickImage();
    if (pic != null) {
      document.value = '';
      galleryDocument.value = pic.path;
    }
  }

  void removeImageFromList() {
    imagesList.clear();
    galleryImage.value = '';
  }

  void addFeature(String feature) {
    //check if field did'nt exist with same data
    if (!featuresList.contains(feature)) {
      featuresList.add(feature);
    }
  }

  void removeFeature(String featureTodo) {
    featuresList.remove(featureTodo);
  }

  void addAdditionalFeature() {
    if (additionalFeatureNameC.text.isNotEmpty &&
        additionalFeatureValueC.text.isNotEmpty) {
      final additionalFeature = AdditionalFeature(
          name: additionalFeatureNameC.text,
          value: additionalFeatureValueC.text.toString());

      // Check if the additionalFeaturesList already contains an item with the same name
      if (!additionalFeaturesList.contains(additionalFeature)) {
        additionalFeaturesList.add(additionalFeature);
      }

      additionalFeatureNameC.clear();
      additionalFeatureValueC.clear();
    }
  }

  void removeAdditionalFeature(AdditionalFeature additionalfeature) {
    additionalFeaturesList.remove(additionalfeature);
  }

  void step1Validator() {
    step1Validate.value = true;
    if (titleC.value.text.isNotEmpty &&
            priceC.value.text.isNotEmpty &&
            propertyType.isNotEmpty &&
            imagesList.isNotEmpty ||
        galleryImage.isNotEmpty) {
      pageIndex(pageIndex.value + 1);
      step1Validate.value = false;
    }
  }

  void step2Validator() {
    step2Validate.value = true;
    if (city.isNotEmpty) {
      pageIndex(pageIndex.value + 1);
      step2Validate.value = false;
    }
  }

  Future<void> fetchNeighborhood() async {
    final url = Uri.parse('https://app.webaotoolkit.com/api/neighborhood');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse JSON
        final data = jsonDecode(response.body);

        // Extract names
        List<dynamic> neighborhoodData = data['neighborhood'];
        List<String> names = neighborhoodData
            .map((neighbor) => neighbor['name'].toString())
            .toList();

        neighborhoodList.addAll(names);

        // Update state with names
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('Error: $e');
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

  @override
  void onInit() {
    fetchCity();
    fetchNeighborhood();
    super.onInit();
  }
}
