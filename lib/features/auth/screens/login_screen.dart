import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/auth/controllers/auth_controller.dart';
import 'package:habitat54/features/auth/screens/forgot_password_screen.dart';
import 'package:habitat54/features/auth/screens/signup_screen.dart';
import 'package:habitat54/features/auth/widgets/auth_sociel_button.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
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
                            'Login',
                            style: AppTextStyle.boldBlack30.copyWith(fontSize: 36, fontWeight: FontWeight.w900),
                          ),
                          Column(
                            children: [
                              AuthTextField(
                                controller: authC.loginEmailC,
                                text: 'Email',
                                formKey: emailFormKey,
                                leadingIcon: Icons.email_outlined,
                                validator: (value) {
                                  String? error = authC.emailValidator(value);
                                  return error;
                                },
                              ),
                              AuthTextField(
                                leadingIcon: Icons.lock_outline,
                                controller: authC.loginPasswordC,
                                obscureText: authC.hidePassword.value,
                                formKey: passwordFormKey,
                                text: 'Password',
                                trailing: authC.hidePassword.value ? Icons.visibility_off : Icons.visibility,
                                trailingTap: () {
                                  authC.hidePassword.value ? authC.hidePassword(false) : authC.hidePassword(true);
                                },
                                validator: (value) {
                                  String? error = authC.passwordValidator(value);
                                  return error;
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      authC.forgetPasswordC.text = authC.loginEmailC.text;
                                      Get.to(() => ForgetPasswordScreen());
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: AppTextStyle.mediumBlack14.copyWith(color: AppColors.primary),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 15),
                              LongButton(
                                text: 'Login',
                                onPressed: () {
                                  if (emailFormKey.currentState!.validate() &&
                                      passwordFormKey.currentState!.validate()) {
                                    authC.loginUser();
                                  }
                                },
                              ),
                              // AuthSocielButton(
                              //   google: () async{
                              //     await GoogleSignIn().signOut();
                              //     authC.signInWithGoogle(login: true);
                              //   },
                              //   // facebook: () {
                              //   //   authC.signInWithFacebook(login: true);
                              //   // },
                              // ),
                              const SizedBox(height: 15),
                              LongButton(
                                textColor: AppColors.black,
                                color: const Color(0xfff4f4f4),
                                text: 'Sign up',
                                onPressed: () {
                                  Get.to(() => SignupScreen());
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
      ),
    );
  }
}
