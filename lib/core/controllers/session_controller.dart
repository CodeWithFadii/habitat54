import 'dart:developer';

import 'package:get/get.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController {
  RxString id = ''.obs;

  checkSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String data = pref.getString(AppConstants.userID) ?? '';
    log(data.toString());
    id.value = data;
  }

  assignSession(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(AppConstants.userID, userId);
    id.value = userId;
  }
}
