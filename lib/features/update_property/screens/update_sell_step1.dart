import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/sell/widgets/custom_dropdown.dart';
import 'package:habitat54/features/sell/widgets/sell_textfield.dart';
import 'package:habitat54/features/update_property/controllers/update_sell_controller.dart';

class UpdateSellStep1 extends StatelessWidget {
   UpdateSellStep1({
    super.key,
  });
  final sellC = Get.find<UpdateSellController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: 185,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MaterialButton(
          onPressed: () {
            sellC.step1Validator();
          },
          color: AppColors.primary,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue',
                style: AppTextStyle.mediumWhite14,
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () {
              return Column(
                children: [
                  SellTextField(
                      controller: sellC.titleC,
                      label: 'Title',
                      error: sellC.step1Validate.value
                          ? sellC.titleC.text.isNotEmpty
                              ? false
                              : true
                          : false),
                  SellTextField(
                    controller: sellC.descriptionC,
                    label: 'Description',
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                  ),
                  SellTextField(
                      controller: sellC.priceC,
                      label: 'Price',
                      keyboardType: TextInputType.number,
                      error: sellC.step1Validate.value
                          ? sellC.priceC.text.isNotEmpty
                              ? false
                              : true
                          : false),
                  CustomDropDown(
                    title: 'Property Type',
                    itemsList: const [
                      'Apartment',
                      'Villa',
                      'Office',
                      'Shop',
                    ],
                    onChanged: (value) {
                      sellC.propertyType.value = value!;
                    },
                    value: sellC.propertyType.value,
                    error: sellC.step1Validate.value
                        ? sellC.propertyType.value.isNotEmpty
                            ? false
                            : true
                        : false,
                  ),
                  CustomDropDown(
                    value: sellC.offerType.value,
                    title: 'Offer Type',
                    itemsList: const ['For Rent', 'For Sale'],
                    onChanged: (value) {
                      sellC.offerType.value = value!;
                    },
                  ),
                  sellC.imagesList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 190,
                                child: MaterialButton(
                                  onPressed: () async {
                                    await sellC.getImagesFromGallery();
                                  },
                                  color: AppColors.grey,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.upload_file,
                                        color: AppColors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Upload Image',
                                        style: AppTextStyle.mediumWhite14,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              sellC.step1Validate.value
                                  ? sellC.imagesList.isEmpty &&
                                          sellC.galleryImage.isEmpty
                                      ? const Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            'Upload atleast 1 image',
                                            style: TextStyle(
                                                color: AppColors.primary),
                                          ),
                                        )
                                      : const SizedBox()
                                  : const SizedBox()
                            ],
                          ),
                        )
                      : const SizedBox(),
                  Visibility(
                    visible: sellC.imagesList.isNotEmpty ||
                        sellC.galleryImage.isNotEmpty,
                    child: SizedBox(
                      height: 120,
                      child: Column(
                        children: [
                          sellC.imagesList.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 10),
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    color: AppColors.grey,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: sellC.imagesList.first,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const Loader(),
                                    errorWidget: (context, url, error) =>
                                        const SizedBox(
                                      width: double.infinity,
                                      child: Icon(
                                        Icons.error,
                                      ),
                                    ),
                                  ),
                                )
                              : sellC.galleryImage.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 10),
                                      height: 70,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: AppColors.grey,
                                      ),
                                      child: Image.file(
                                        File(sellC.galleryImage.value),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox(),
                          const SizedBox(height: 5),
                          GestureDetector(
                              onTap: () {
                                sellC.removeImageFromList();
                              },
                              child: const Icon(Icons.close))
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
