import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

Widget alertDialog(
    {required VoidCallback okPressed,
    String message = 'Are you sure to Logout ?'}) {
  return AlertDialog(
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(),
    contentPadding: const EdgeInsets.all(15),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: AppTextStyle.boldBlack16,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                Get.back();
              },
              color: AppColors.white,
              elevation: 6,
              height: 38,
              minWidth: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'No',
                style: AppTextStyle.mediumBlack12,
              ),
            ),
            const SizedBox(width: 20),
            MaterialButton(
              onPressed: okPressed,
              color: AppColors.primary,
              elevation: 0,
              height: 38,
              minWidth: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Yes',
                style: AppTextStyle.mediumWhite12,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<XFile?> pickImage() async {
  final pic = await ImagePicker().pickImage(source: ImageSource.gallery);
  return pic;
}

Future<List<XFile>?> pickMultipleImages() async {
  final pics = await ImagePicker().pickMultiImage();
  return pics;
}

void showCustomSnackbar(String message) {
  Get.snackbar(
    '',
    '',
    messageText: Text(
      message,
      style: const TextStyle(color: AppColors.black, fontSize: 16),
      textAlign: TextAlign.center,
    ),
    snackPosition: SnackPosition.BOTTOM,
    padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    backgroundColor: Colors.white,
    borderRadius: 8,
    duration: const Duration(seconds: 2),
    animationDuration: const Duration(milliseconds: 300),
  );
}

void launchUrlWebsite(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    launchUrl(uri);
  } else {
    // showCustomSnackbar('Something went wrong from our side');
  }
}

List<String> parseDataString(Property property) {
  final dataString = property.features?.first ?? '';
  if (dataString == '[[]]') {
    return [];
  }
  if (dataString.length < 4) {
    return [];
  }
  String cleanedString = dataString.substring(1, dataString.length - 1);
  List<String> list = cleanedString.split(',');
  for (int i = 0; i < list.length; i++) {
    list[i] = list[i].replaceAll('"', '').trim();
  }
  return list;
}
