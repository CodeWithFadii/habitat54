import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/auth/screens/forgot_password_screen.dart';
import 'package:habitat54/features/auth/screens/signup_screen.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';
import 'package:habitat54/features/dashboard/dashboard.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.authBackground,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: AppTextStyle.boldBlack30
                      .copyWith(fontSize: 36, fontWeight: FontWeight.w900),
                ),
                Column(
                  children: [
                    AuthTextField(
                      // controller: authC.signupEmailC,
                      text: 'Email',
                      formKey: emailFormKey,
                      leadingIcon: Icons.email_outlined,
                      // validator: (value) {
                      //   String? error = authC.emailValidator(value);
                      //   return error;
                      // },
                    ),
                    AuthTextField(
                      // controller: authC.signupEmailC,
                      text: 'Password',
                      formKey: passwordFormKey,
                      leadingIcon: Icons.lock_outline,
                      obscureText: true,
                      trailing: Icons.visibility_off,
                      // validator: (value) {
                      //   String? error = authC.emailValidator(value);
                      //   return error;
                      // },
                    ),
                    // Obx(
                    //   () => AuthTextField(
                    //     controller: authC.signupPasswordC,
                    //     obscureText: authC.hidePassword.value,
                    //     formKey: passwordFormKey,
                    //     text: 'Password',
                    //     trailing: authC.hidePassword.value
                    //         ? Icons.visibility_off
                    //         : Icons.visibility,
                    //     trailingTap: () {
                    //       authC.hidePassword.value
                    //           ? authC.hidePassword(false)
                    //           : authC.hidePassword(true);
                    //     },
                    //     validator: (value) {
                    //       String? error = authC.passwordValidator(value);
                    //       return error;
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ForgetPasswordScreen());
                          },
                          child: Text(
                            'Forgot Password?',
                            style: AppTextStyle.mediumBlack14
                                .copyWith(color: AppColors.primary),
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
                        // if (nameFormKey.currentState!.validate()) {}
                        // if (emailFormKey.currentState!.validate()) {}
                        // if (passwordFormKey.currentState!.validate()) {}
                        Get.offAll(() => const DashBoard());
                      },
                    ),
                    const SizedBox(height: 15),
                    LongButton(
                      textColor: AppColors.black,
                      color: const Color(0xfff4f4f4),
                      text: 'Sign up',
                      onPressed: () {
                        // if (nameFormKey.currentState!.validate()) {}
                        // if (emailFormKey.currentState!.validate()) {}
                        // if (passwordFormKey.currentState!.validate()) {}
                        Get.to(() => SignupScreen());
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
