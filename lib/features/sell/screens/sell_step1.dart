import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/sell/controllers/sell_controller.dart';
import 'package:habitat54/features/sell/widgets/custom_dropdown.dart';
import 'package:habitat54/features/sell/widgets/sell_textfield.dart';

class SellStep1 extends StatelessWidget {
  const SellStep1({super.key, required this.sellC});
  final SellController sellC;

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
          child: Obx(() {
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
                                ? sellC.imagesList.isEmpty
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
                  visible: sellC.imagesList.isNotEmpty,
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
                                  child: Image.file(
                                    File(
                                      sellC.imagesList.first,
                                    ),
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
                      )),
                )
                // Visibility(
                //   visible: sellC.imagesList.isNotEmpty,
                //   child: SizedBox(
                //     height: 120,
                //     child: ListView.builder(
                //       itemCount: sellC.imagesList.length,
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, index) {
                //         return Column(
                //           children: [
                //             Container(
                //               margin: const EdgeInsets.symmetric(horizontal: 7),
                //               height: 70,
                //               width: 70,
                //               decoration: const BoxDecoration(
                //                 color: AppColors.grey,
                //               ),
                //               child: Image.file(
                //                 File(
                //                   sellC.imagesList[index].path,
                //                 ),
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //             SizedBox(height: 5),
                //             GestureDetector(
                //                 onTap: () {
                //                   sellC.removeImageFromList(index);
                //                 },
                //                 child: Icon(Icons.close))
                //           ],
                //         );
                //       },
                //     ),
                //   ),
                // )
              ],
            );
          }),
        ),
      ),
    );
  }
}
