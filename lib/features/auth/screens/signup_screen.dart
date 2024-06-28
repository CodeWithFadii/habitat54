import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/features/auth/screens/login_screen.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';
import 'package:habitat54/features/auth/widgets/sociel_button.dart';
import 'package:habitat54/features/dashboard/dashboard.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final nameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(),
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
                  'Sign Up',
                  style: AppTextStyle.boldBlack30
                      .copyWith(fontSize: 36, fontWeight: FontWeight.w900),
                ),
                Column(
                  children: [
                    AuthTextField(
                      // controller: authC.signupnNmeC,
                      formKey: nameFormKey,
                      text: 'Name', leadingIcon: Icons.person_outline,
                      // validator: (value) {
                      //   String? error = authC.nameValidator(value);
                      //   return error;
                      // },
                    ),
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
                    Container(
                      padding: EdgeInsets.only(left: 40, top: 20, bottom: 10),
                      child: DropdownButton<String>(
                        hint: const Text(
                          'Agent',
                          style: TextStyle(color: AppColors.grey),
                        ),
                        style: AppTextStyle.mediumBlack16,
                        // value: 'Property Type', // Currently selected item
                        isExpanded:
                            true, // Make the dropdown button expand to full width
                        dropdownColor: Colors.white,
                        underline: Divider(
                          height: 1,
                          color: AppColors.grey,
                        ),

                        onChanged: (newValue) {},

                        items: ['Agent', 'Agency', 'Buyer'].map((String item) {
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
                      text: 'Sign up',
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
                      text: 'Login',
                      onPressed: () {
                        // if (nameFormKey.currentState!.validate()) {}
                        // if (emailFormKey.currentState!.validate()) {}
                        // if (passwordFormKey.currentState!.validate()) {}
                        Get.to(() => LoginScreen());
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
