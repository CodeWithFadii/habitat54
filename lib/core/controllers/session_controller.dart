import 'dart:developer';

import 'package:get/get.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController {
  RxString id = ''.obs;
  RxBool isVarified = false.obs;
  RxBool sociel = false.obs;
  checkSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id.value = pref.getString(AppConstants.userID) ?? '';
    isVarified.value = pref.getBool(AppConstants.isVarified) ?? false;
    sociel.value = pref.getBool(AppConstants.sociel) ?? false;
    log('id: $id');
    log('isEmailVerified: $isVarified');
    log('sociel: $sociel');
  }

  assignSession(String? userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppConstants.userID, userId!);
    id.value = userId;
  }

  assignVarification(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(AppConstants.isVarified, value);
    isVarified.value = value;
  }

  assignSociel(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(AppConstants.sociel, value);
    sociel.value = value;
  }
}
