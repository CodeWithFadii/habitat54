import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';
import 'package:habitat54/features/profile/controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final nameFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  final profileC = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.7), // Shadow color
                  spreadRadius: 0.1, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: const Offset(5,
                      0), // Offset in the vertical direction (negative for top shadow)
                ),
              ],
            ),
            child: AppBar(
              centerTitle: true,
              title: Text(
                'Edit Profile',
                style: AppTextStyle.boldBlack18,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Obx(
              () {
                return profileC.isLoading.value
                    ? const Loader()
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              profileC.pickProfileImage();
                            },
                            child: profileC.profilePic.value.isNotEmpty
                                ? Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          File(profileC.profilePic.value),
                                        ),
                                      ),
                                    ),
                                  )
                                : profileC.user.value!.image == null
                                    ? Container(
                                        height: 60,
                                        width: 60,
                                        decoration: const BoxDecoration(
                                            color: AppColors.grey,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.person,
                                          size: 30,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                          imageUrl: profileC.user.value!.image!,
                                        ),
                                      ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Select Profile Photo'),
                          const SizedBox(height: 20),
                          AuthTextField(
                            controller: profileC.nameC,
                            formKey: nameFormKey,
                            text: 'Name',
                            leadingIcon: Icons.person_outline,
                            validator: (value) {
                              String? error = profileC.nameValidator(value);
                              return error;
                            },
                          ),
                          AuthTextField(
                            controller: profileC.phoneC,
                            text: 'Phone Number',
                            formKey: phoneFormKey,
                            leadingIcon: Icons.phone_outlined,
                            validator: (value) {
                              String? error = profileC.phoneValidator(value);
                              return error;
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 40, top: 20, bottom: 10),
                            child: DropdownButton<String>(
                              hint: const Text(
                                'Agent',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              style: AppTextStyle.mediumBlack16,
                              value: profileC.roles.isNotEmpty
                                  ? profileC.roles.value
                                  : null, // Currently selected item
                              isExpanded:
                                  true, // Make the dropdown button expand to full width
                              dropdownColor: Colors.white,
                              underline: const Divider(
                                height: 1,
                                color: AppColors.grey,
                              ),

                              onChanged: (newValue) {
                                profileC.roles.value = newValue!;
                              },

                              items: ['Agent', 'Agency', 'Buyer']
                                  .map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(item),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const Spacer(),
                          LongButton(
                            textColor: AppColors.white,
                            color: AppColors.primary,
                            text: 'Update',
                            onPressed: () {
                              if (nameFormKey.currentState!.validate() &&
                                  phoneFormKey.currentState!.validate()) {
                                profileC.updateUser(profileC.user.value!.email);
                              }
                            },
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
