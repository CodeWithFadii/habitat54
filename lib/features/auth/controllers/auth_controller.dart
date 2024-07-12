import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/core/utils.dart';
import 'package:habitat54/core/controllers/session_controller.dart';
import 'package:habitat54/features/auth/models/auth_model.dart';
import 'package:habitat54/features/auth/screens/change_password_screen.dart';
import 'package:habitat54/features/auth/screens/forgot_password_screen.dart';
import 'package:habitat54/features/auth/screens/login_screen.dart';
import 'package:habitat54/features/auth/screens/pin_input_screen.dart';
import 'package:habitat54/features/dashboard/dashboard.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxString role = 'Buyer'.obs;
  TextEditingController loginEmailC = TextEditingController();
  TextEditingController loginPasswordC = TextEditingController();
  TextEditingController signupEmailC = TextEditingController();
  TextEditingController signupPhoneC = TextEditingController();
  TextEditingController signupPasswordC = TextEditingController();
  TextEditingController signupNameC = TextEditingController();
  TextEditingController forgetPasswordC = TextEditingController();
  TextEditingController pinC = TextEditingController();
  RxBool hidePassword = true.obs;

  void signupUser() async {
    final url = Uri.parse('${AppConstants.baseUrl}add_user');
    final Map<String, dynamic> requestBody = {
      'image': '',
      'name': signupNameC.text.toString(),
      'email': signupEmailC.text.toString(),
      'password': signupPasswordC.text.toString(),
      'number': signupPhoneC.text.toString(),
      'role': role.value.toString(),
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      isLoading(true);
      //sending request
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        log('success');
        //user created successfuly
        final data = json.decode(response.body);
        final user = AuthModel.fromJson(data);
        log(data.toString());

        final sessionC = Get.find<SessionController>();
        sessionC.assignSession(user.student.id.toString());

        Get.to(() => PinInputScreen(email: signupEmailC.text.toString()));
        isLoading(false);
      } else if (response.statusCode == 422) {
        //user already exists with same metadata
        final data = json.decode(response.body);
        showCustomSnackbar(data['message']);
      } else {
        //something went wrong from the serverside or user side
        showCustomSnackbar('Something went wrong please try again');
      }
      isLoading(false);
    } on Exception catch (e) {
      showCustomSnackbar(e.toString());
      isLoading(false);
    }
  }

  void loginUser() async {
    final url = Uri.parse('${AppConstants.baseUrl}login');
    final Map<String, dynamic> requestBody = {
      'email': loginEmailC.text.toString(),
      'password': loginPasswordC.text.toString(),
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      isLoading(true);
      //sending request
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        //user created successfuly
        final data = json.decode(response.body);
        final user = AuthModel.fromJson(data);
        log(user.message);

        final sessionC = Get.find<SessionController>();
        sessionC.assignSession(user.student.id.toString());
        sessionC.assignVarification(true);

        Get.offAll(() => DashBoard());
      } else if (response.statusCode == 401) {
        //user already exists with same metadata
        final data = json.decode(response.body);
        showCustomSnackbar(data['message']);
      } else if (response.statusCode == 403) {
        //email not varified
        final data = json.decode(response.body);
        showCustomSnackbar(data['message']);
        resendCode(loginEmailC.text);
        Get.to(() => PinInputScreen(
              email: loginEmailC.text.toString(),
            ));
      } else {
        //something went wrong from the serverside or user side
        showCustomSnackbar('Something went wrong please try again');
      }
      isLoading(false);
    } on Exception catch (e) {
      showCustomSnackbar(e.toString());
      isLoading(false);
    }
  }

  Future<void> resendCode(String email, {bool resetPassword = false}) async {
    final url = Uri.parse('${AppConstants.baseUrl}resend_code');
    Map<String, dynamic> body = {'email': email};
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    isLoading.value = true;
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      if (resetPassword) {
        Get.to(() => ChnagePasswordPinScreen(
              email: email,
            ));
      }
      showCustomSnackbar('Code sent');
      isLoading.value = false;
    } else if (response.statusCode == 404) {
      final data = json.decode(response.body);
      isLoading.value = false;
      showCustomSnackbar(data['message']);
    } else {
      isLoading.value = false;
      //something went wrong from the serverside or user side
      showCustomSnackbar('Something went wrong please try again');
    }
    isLoading.value = false;
  }

  void verifyCode(String code, bool resetPassword, {String? email}) async {
    final url = Uri.parse('${AppConstants.baseUrl}account_verification');
    Map<String, dynamic> body = {'code': code};
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    isLoading.value = true;
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      log('Success');
      if (resetPassword) {
        Get.to(() => ChangePasswordScreen(
              email: email!,
            ));
      } else {
        final sessionC = Get.find<SessionController>();
        sessionC.assignVarification(true);
        Get.offAll(() => DashBoard());
      }

      isLoading.value = false;
    } else if (response.statusCode == 404) {
      showCustomSnackbar('Invaid Code');
      isLoading.value = false;
    } else {
      isLoading.value = false;
      //something went wrong from the serverside or user side
      showCustomSnackbar('Something went wrong please try again');
    }
    isLoading.value = false;
  }

  void changePassword(String email, String password) async {
    final url = Uri.parse('${AppConstants.baseUrl}password/updatepass');
    Map<String, dynamic> body = {"email": email, "password": password};
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    isLoading.value = true;
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      log('Success');

      Get.offAll(() => LoginScreen());

      isLoading.value = false;
    } else if (response.statusCode == 404) {
      showCustomSnackbar('Your Email does not exist');
      isLoading.value = false;
    } else {
      isLoading.value = false;
      //something went wrong from the serverside or user side
      showCustomSnackbar('Something went wrong please try again');
    }
    isLoading.value = false;
  }

  //email validator method for validate email
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

  //password validator method for validate pasword
  passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'This field in required';
    }
    if (value.length < 6) {
      return 'Password must be more than 5 characters';
    }
  }

  // @override
  // void onClose() {
  //   loginEmailC.dispose();
  //   loginPasswordC.dispose();
  //   forgetPasswordC.dispose();
  //   signupEmailC.dispose();
  //   signupNameC.dispose();
  //   signupPasswordC.dispose();
  //   super.onClose();
  // }
}
