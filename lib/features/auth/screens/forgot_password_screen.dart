import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.authBackground,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forgot Password',
                  style: AppTextStyle.boldBlack30
                      .copyWith(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      AuthTextField(
                        leadingIcon: Icons.email_outlined,
                        formKey: formKey,
                        // validator: (value) {
                        //   String? error = authC.emailValidator(value);
                        //   return error;
                        // },
                        text: 'Email',
                        // controller: authC.forgetPasswordC,
                      ),
                      const SizedBox(height: 55),
                      LongButton(
                        text: 'SEND',
                        onPressed: () {
                          // if (formKey.currentState!.validate()) {}
                          // Get.offAll(() => const DashBoard());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
