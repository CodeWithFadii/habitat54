import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/auth/controllers/auth_controller.dart';
import 'package:habitat54/features/auth/screens/login_screen.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';
import 'package:pinput/pinput.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController? password1C;
  TextEditingController? password2C;
  final authC = Get.find<AuthController>();

  final password1FormKey = GlobalKey<FormState>();

  final password2FormKey = GlobalKey<FormState>();

  @override
  void initState() {
    password1C = TextEditingController();
    password2C = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    password1C!.dispose();
    password2C!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 70,
          leading: BackButton(
            onPressed: () {
              Get.back();
            },
            color: AppColors.black,
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Obx(() {
              return authC.isLoading.value
                  ? Loader()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Change Password',
                          style: AppTextStyle.boldBlack30.copyWith(
                              fontSize: 32, fontWeight: FontWeight.w900),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              const Text(
                                'Change password for this email',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.email,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              AuthTextField(
                                leadingIcon: Icons.lock_outline,
                                controller: password1C,
                                obscureText: authC.hidePassword.value,
                                formKey: password1FormKey,
                                text: 'Password',
                                trailing: authC.hidePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                trailingTap: () {
                                  authC.hidePassword.value
                                      ? authC.hidePassword(false)
                                      : authC.hidePassword(true);
                                },
                                validator: (value) {
                                  String? error = passwordValidator(value);
                                  return error;
                                },
                              ),
                              SizedBox(height: 10),
                              AuthTextField(
                                leadingIcon: Icons.lock_outline,
                                controller: password2C,
                                obscureText: authC.hidePassword.value,
                                formKey: password2FormKey,
                                text: 'Confirm Password',
                                trailing: authC.hidePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                trailingTap: () {
                                  authC.hidePassword.value
                                      ? authC.hidePassword(false)
                                      : authC.hidePassword(true);
                                },
                                validator: (value) {
                                  String? error = passwordValidator(value);
                                  return error;
                                },
                              ),
                              const SizedBox(height: 55),
                              LongButton(
                                text: 'CHANGE',
                                onPressed: () {
                                  if (password1FormKey.currentState!
                                          .validate() &&
                                      password2FormKey.currentState!
                                          .validate()) {
                                    authC.changePassword(widget.email,
                                        password2C!.text.toString());
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }

  passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'This field in required';
    }
    if (value.length < 6) {
      return 'Password must be more than 5 characters';
    }
    if (password1C!.text != password2C!.text) {
      return 'Password must be same';
    }
  }
}
