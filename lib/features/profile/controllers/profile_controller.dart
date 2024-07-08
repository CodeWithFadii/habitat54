import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/core/controllers/session_controller.dart';
import 'package:habitat54/features/profile/models/user.dart';
import 'package:habitat54/features/profile/screens/edit_profile_screen.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:http/http.dart' as http;
import 'package:habitat54/core/utils.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  var user = Rx<User?>(null);
  RxString profilePic = ''.obs;
  RxString roles = 'Agent'.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  Future<void> getUser() async {
    final sessionC = Get.find<SessionController>();
    final url = Uri.parse("${AppConstants.baseUrl}users/${sessionC.id.value}");

    try {
      if (sessionC.id.value.isNotEmpty) {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          user.value = User.fromJson(data['user']);
          log(data.toString());
        } else {
          throw Exception('Failed to load user');
        }
      }
    } catch (e) {
      // Handle errors here, for example show snackbar
      showCustomSnackbar('Something went wrong, please try again');
      // Rethrow the exception to propagate it upwards
    }
  }

  Future<void> updateUser(String email) async {
    final sessionC = Get.find<SessionController>();
    final url =
        Uri.parse("${AppConstants.baseUrl}edit_user/${sessionC.id.value}");
    final Map<String, String> fields = {
      'name': nameC.text.toString(),
      'email': email,
      'number': phoneC.text.toString(),
      'role': roles.value.toString(),
    };

    try {
      isLoading(true);

      final request = http.MultipartRequest('POST', url);

      // Add fields to the request
      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      // Check if user selected an image
      if (profilePic.value.isNotEmpty) {
        // Add image file to the request
        request.files
            .add(await http.MultipartFile.fromPath('image', profilePic.value));
      }

      // Send the request
      final response = await request.send();

      // Process the response
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        user.value = User.fromJson(data['user']);
        Get.back();
        log(data.toString());
      } else if (response.statusCode == 422) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        showCustomSnackbar(data['message']);
      } else {
        print(response.statusCode.toString());
        showCustomSnackbar('Something went wrong, please try again');
      }
    } on Exception catch (e) {
      showCustomSnackbar(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<List<Property>> getMyProperties() async {
    final sessionC = Get.find<SessionController>();
    List<Property> myPropertyList = [];
    final url =
        Uri.parse('${AppConstants.baseUrl}products/${sessionC.id.value}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i in data['products']) {
        myPropertyList.add(
          Property.fromJson(i),
        );
      }
    } else {
      log(response.statusCode.toString());
    }
    return myPropertyList;
  }

  void navigateToEditScreen(User user) {
    nameC.text = user.name;
    phoneC.text = user.number;
    roles.value = user.role;
    profilePic.value = '';
    Get.to(() => EditProfileScreen());
  }

  void pickProfileImage() async {
    final data = await pickImage();
    if (data != null) {
      profilePic.value = data.path;
    }
  }

  emailValidator(String? email) {
    if (email!.isEmpty) {
      return 'This field in required';
    }
    final emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      return 'Please enter valid email adress';
    }
  }

  //name validator method for validate name
  nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'This field in required';
    }
    if (value.length < 3) {
      return 'Name must be more than 5 characters';
    }
  }

  //name validator method for validate name
  phoneValidator(String? value) {
    if (value!.isEmpty) {
      return 'This field in required';
    }
    if (value.length < 8) {
      return 'Enter a valid phone number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Only numbers allowed in this field';
    }
  }

  @override
  void onInit() async {
    await getUser();
    super.onInit();
  }
}
