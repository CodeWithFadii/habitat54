import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/sell/widgets/previous_next_button.dart';
import 'package:habitat54/features/sell/widgets/sell_textfield.dart';
import 'package:habitat54/features/update_property/controllers/update_sell_controller.dart';

class UpdateSellStep4 extends StatelessWidget {
  const UpdateSellStep4({super.key, required this.sellC});
  final UpdateSellController sellC;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PreviousNextButton(
        previous: () {
          sellC.pageIndex(sellC.pageIndex.value - 1);
        },
        next: () {
          sellC.uploadProperty();
        },
        nextText: 'Update',
      ),
      body: SafeArea(
        child: Obx(() {
          return sellC.isLoading.value
              ? const Center(child: Loader())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SellTextField(
                        controller: sellC.youtubeLink,
                        label: 'Add youtube video link',
                        keyboardType: TextInputType.text,
                      ),
                      sellC.document.isEmpty
                          ? Container(
                              width: 220,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: MaterialButton(
                                onPressed: () {
                                  sellC.getDocument();
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
                                      'Upload Attachment',
                                      style: AppTextStyle.mediumWhite14,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Visibility(
                        visible: sellC.document.isNotEmpty ||
                            sellC.galleryDocument.isNotEmpty,
                        child: SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              sellC.document.isNotEmpty
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 10),
                                      height: 70,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: AppColors.grey,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: sellC.document.value,
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
                                  : sellC.galleryDocument.isNotEmpty
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 10),
                                          height: 70,
                                          width: 70,
                                          decoration: const BoxDecoration(
                                            color: AppColors.grey,
                                          ),
                                          child: Image.file(
                                            File(sellC.galleryDocument.value),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const SizedBox(),
                              const SizedBox(height: 5),
                              GestureDetector(
                                  onTap: () {
                                    sellC.document.value = '';
                                    sellC.galleryDocument.value = '';
                                  },
                                  child: const Icon(Icons.close))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text(
                          'Addional Features',
                          style: AppTextStyle.boldBlack16,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SellTextField(
                              controller: sellC.additionalFeatureNameC,
                              label: 'Name',
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Expanded(
                            child: SellTextField(
                              controller: sellC.additionalFeatureValueC,
                              label: 'Value',
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 190,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: MaterialButton(
                          onPressed: () {
                            sellC.addAdditionalFeature();
                          },
                          color: AppColors.primary,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: AppColors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Add',
                                style: AppTextStyle.mediumWhite14,
                              )
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        shrinkWrap: true,
                        itemCount: sellC.additionalFeaturesList.length,
                        itemBuilder: (context, index) {
                          final feature = sellC.additionalFeaturesList[index];
                          return ListTile(
                            title: Text('${feature.name} : ${feature.value}'),
                            trailing: GestureDetector(
                              onTap: () =>
                                  sellC.removeAdditionalFeature(feature),
                              child: const Icon(
                                Icons.delete,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

class AdditionalFeature {
  final String name;
  final String value;

  AdditionalFeature({required this.name, required this.value});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }

  // Override equality operator to compare AdditionalFeature objects by name
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdditionalFeature &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}