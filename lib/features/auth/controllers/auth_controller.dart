import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController loginEmailC = TextEditingController();
  TextEditingController loginPasswordC = TextEditingController();
  TextEditingController signupEmailC = TextEditingController();
  TextEditingController signupPasswordC = TextEditingController();
  TextEditingController signupNameC = TextEditingController();
  TextEditingController forgetPasswordC = TextEditingController();

  RxBool hidePassword = true.obs;

  //email validator method for validate email
  emailValidator(String? email) {
    if (email!.isEmpty) {
      return 'Please enter email adress';
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
      return 'Please enter your name';
    }
    if (value.length < 3) {
      return 'Name must be more than 5 characters';
    }
  }

  //password validator method for validate pasword
  passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password must be more than 5 characters';
    }
  }

  @override
  void onClose() {
    loginEmailC.dispose();
    loginPasswordC.dispose();
    forgetPasswordC.dispose();
    signupEmailC.dispose();
    signupNameC.dispose();
    signupPasswordC.dispose();
    super.onClose();
  }
}
