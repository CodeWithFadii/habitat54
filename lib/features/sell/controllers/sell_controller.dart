import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/utils.dart';
import 'package:image_picker/image_picker.dart';

class SellController extends GetxController {
  //steps controller
  RxInt pageIndex = 0.obs;
  RxList<XFile> imagesList = <XFile>[].obs;
  RxList<String> additionalFeaturesList = <String>[].obs;
    TextEditingController additionalFeatureC = TextEditingController();


  Future<void> getImagesFromGallery() async {
    final pics = await pickMultipleImages();
    if (pics != null) {
      imagesList.addAll(pics);
    }
  }

  void removeImageFromList(int index) {
    imagesList.removeAt(index);
  }

  void addAdditionalFeature(String feature) {
    additionalFeaturesList.add(feature);
  }

  void removeAdditionalFeature(String feature) {
    additionalFeaturesList.remove(feature);
  }


}
