import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/auth/controllers/auth_controller.dart';
import 'package:habitat54/features/auth/screens/login_screen.dart';
import 'package:habitat54/features/auth/widgets/auth_sociel_button.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final nameFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Obx(
            () {
              return authC.isLoading.value
                  ? const Loader()
                  : SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Sign Up',
                                style: AppTextStyle.boldBlack30.copyWith(
                                    fontSize: 36, fontWeight: FontWeight.w900),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  AuthTextField(
                                    controller: authC.signupNameC,
                                    formKey: nameFormKey,
                                    text: 'Name',
                                    leadingIcon: Icons.person_outline,
                                    validator: (value) {
                                      String? error =
                                          authC.nameValidator(value);
                                      return error;
                                    },
                                  ),
                                  AuthTextField(
                                    keyboardType: TextInputType.number,
                                    controller: authC.signupPhoneC,
                                    formKey: phoneFormKey,
                                    text: 'Phone',
                                    leadingIcon: Icons.phone_outlined,
                                    validator: (value) {
                                      String? error =
                                          authC.phoneValidator(value);
                                      return error;
                                    },
                                  ),
                                  AuthTextField(
                                    controller: authC.signupEmailC,
                                    text: 'Email',
                                    formKey: emailFormKey,
                                    leadingIcon: Icons.email_outlined,
                                    validator: (value) {
                                      String? error =
                                          authC.emailValidator(value);
                                      return error;
                                    },
                                  ),
                                  AuthTextField(
                                    leadingIcon: Icons.lock_outline,
                                    controller: authC.signupPasswordC,
                                    obscureText: authC.hidePassword.value,
                                    formKey: passwordFormKey,
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
                                      String? error =
                                          authC.passwordValidator(value);
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
                                      value: authC.role
                                          .value, // Currently selected item
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
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(item),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 15),
                                LongButton(
                                  text: 'Sign up',
                                  onPressed: () {
                                    if (nameFormKey.currentState!.validate() &&
                                        phoneFormKey.currentState!.validate() &&
                                        emailFormKey.currentState!.validate() &&
                                        passwordFormKey.currentState!
                                            .validate()) {
                                      authC.signupUser();
                                    }
                                  },
                                ),
                                AuthSocielButton(
                                  google: () async {
                                    await GoogleSignIn().signOut();
                                    authC.signInWithGoogle(login: false);
                                  },
                                  // facebook: () {
                                  //   authC.signInWithFacebook(login: false);
                                  // },
                                ),
                                const SizedBox(height: 15),
                                LongButton(
                                  textColor: AppColors.black,
                                  color: const Color(0xfff4f4f4),
                                  text: 'Login',
                                  onPressed: () {
                                    Get.to(() => LoginScreen());
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
