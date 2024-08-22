import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/property_payment.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/features/profile/controllers/profile_controller.dart';
import 'package:habitat54/features/profile/screens/my_properties_screen.dart';
import 'package:http/http.dart' as http;
import 'package:habitat54/core/utils.dart';

class SellController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool payment = false.obs;
  RxInt pageIndex = 0.obs;
  RxList<String> imagesList = <String>[].obs;
  RxString document = ''.obs;
  RxList<String> featuresList = <String>[].obs;
  RxList<String> cityList = <String>[].obs;
  RxList<String> neighborhoodList = <String>[].obs;
  RxList<Map<String, String>> additionalFeatures = <Map<String, String>>[].obs;
  // RxList<AdditionalFeature> additionalFeaturesList = <AdditionalFeature>[].obs;
  //DropDownItems
  RxString propertyType = ''.obs;
  RxString offerType = ''.obs;
  RxString city = ''.obs;
  RxString neighborhood = ''.obs;
  //Validators
  RxBool step1Validate = false.obs;
  RxBool step2Validate = false.obs;
  RxBool step3Validate = false.obs;
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

  Future<void> uploadProperty() async {
    final url = Uri.parse('${AppConstants.baseUrl}add_products');
    final profileC = Get.put(ProfileController());
    try {
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
      request.fields['features'] = featuresList.toString();
      request.fields['additional_data'] =
          jsonEncode(additionalFeatures.map((feature) => feature).toList());

      // Add image files if exist
      if (imagesList.isNotEmpty) {
        for (final imagePath in imagesList) {
          log('Adding image: $imagePath'); // Log the image paths being added
          request.files.add(
              await http.MultipartFile.fromPath('upload_image[]', imagePath));
        }
      }

      // Add document file if exists
      if (document.value.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'upload_document', document.value.toString()));
      }

      // Send the request
      final response = await request.send();
      isLoading(false);

      // Handle the response
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = jsonDecode(responseBody);
        log('Response: $data');
        updateValues();
        payment.value = false;
        Get.to(() => const MyPropertiesScreen(isRefresh: true));
        showCustomSnackbar('Property Uploaded');
      } else if (response.statusCode == 500) {
        payment.value = false;
        log(response.statusCode.toString());
        showCustomSnackbar('Property Uploaded');
        updateValues();
        Get.to(() => const MyPropertiesScreen(isRefresh: true));
      } else {
        log('HTTP Error: ${response.statusCode}');
        showCustomSnackbar('Something went wrong while posting');
      }
    } catch (e) {
      log('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  void upload(context) async {
    if (!isLoading.value) {
      if (payment.value) {
        uploadProperty();
      } else {
        isLoading.value = true;
        payment.value = await PropertyPayment().makePayment(context);
        isLoading.value = false;
        if (payment.value) {
          uploadProperty();
        }
      }
    }
  }

  Future<bool> makePayment(context) async {
    isLoading(true);
    bool isPaymentSuccess = await PropertyPayment().makePayment(context);
    isLoading(false);
    return isPaymentSuccess;
  }

  void updateValues() {
    pageIndex.value = 0;
    imagesList.clear();
    document.value = '';
    featuresList.clear();
    // additionalFeaturesList.clear();
    propertyType.value = '';
    offerType.value = '';
    city.value = '';
    neighborhood.value = '';
    step1Validate.value = false;
    step2Validate.value = false;
    step3Validate.value = false;
    titleC.clear();
    descriptionC.clear();
    priceC.clear();
    bedroomsC.clear();
    bathroomsC.clear();
    propertySize.clear();
    featureC.clear();
    youtubeLink.clear();
    additionalFeatures.clear();
    additionalFeatureNameC.clear();
    additionalFeatureValueC.clear();
  }

  Future<void> getImagesFromGallery() async {
    final picList = await pickMultipleImages();
    if (picList != null) {
      for (var i in picList) {
        imagesList.add(i.path);
      }
    }
  }

  Future<void> getDocument() async {
    final pic = await pickImage();
    if (pic != null) {
      document.value = pic.path;
    }
  }

  void removeImageFromList(int index) {
    imagesList.removeAt(index);
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
      Map<String, String> additionalFeature = {
        'name': additionalFeatureNameC.text,
        'value': additionalFeatureValueC.text
      };

      // Check if the additionalFeaturesList already contains an item with the same name
      if (!additionalFeatures.contains(additionalFeature)) {
        additionalFeatures.add(additionalFeature);
      }

      additionalFeatureNameC.clear();
      additionalFeatureValueC.clear();
    }
  }

  void removeAdditionalFeature(Map<String, String> additionalfeature) {
    additionalFeatures.remove(additionalfeature);
  }

// Steps Validate

  void step1Validator() {
    step1Validate.value = true;
    if (titleC.value.text.isNotEmpty &&
        priceC.value.text.isNotEmpty &&
        propertyType.isNotEmpty &&
        imagesList.isNotEmpty) {
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

  void step3Validator() {
    step3Validate.value = true;
    if (bedroomsC.text.isNotEmpty && bathroomsC.text.isNotEmpty) {
      pageIndex(pageIndex.value + 1);
      step3Validate.value = false;
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
