import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/auth/controllers/auth_controller.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';

class AdditionalInformationScreen extends StatelessWidget {
  AdditionalInformationScreen({super.key, required this.user});
  final User user;
  final authC = Get.find<AuthController>();
  final phoneFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Obx(
          () {
            return authC.isLoading.value
                ? const Loader()
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Additional',
                          style: AppTextStyle.boldBlack30.copyWith(
                              fontSize: 36, fontWeight: FontWeight.w900),
                        ),
                        Column(
                          children: [
                            AuthTextField(
                              keyboardType: TextInputType.number,
                              controller: authC.additinalPhoneC,
                              formKey: phoneFormKey,
                              text: 'Phone',
                              leadingIcon: Icons.phone_outlined,
                              validator: (value) {
                                String? error = authC.phoneValidator(value);
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
                                value:
                                    authC.role.value, // Currently selected item
                                isExpanded:
                                    true, // Make the dropdown button expand to full width
                                dropdownColor: Colors.white,
                                underline: const Divider(
                                  height: 1,
                                  color: AppColors.grey,
                                ),

                                onChanged: (newValue) {
                                  authC.role.value = newValue!;
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
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 15),
                            LongButton(
                              textColor: AppColors.white,
                              color: AppColors.primary,
                              text: 'Continue',
                              onPressed: () {
                                if (phoneFormKey.currentState!.validate()) {
                                  authC.socielSignin(user);
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
