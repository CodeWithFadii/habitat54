import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final nameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.grey,
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color: AppColors.white,
                ),
                radius: 30,
              ),
              SizedBox(height: 10),
              Text('Upload Your Profile Photo'),
              SizedBox(height: 20),
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
                text: 'Phone Number',
                formKey: phoneFormKey,
                leadingIcon: Icons.phone_outlined,
                // validator: (value) {
                //   String? error = authC.emailValidator(value);
                //   return error;
                // },
              ),
              const Spacer(),
              LongButton(
                textColor: AppColors.white,
                color: AppColors.primary,
                text: 'Update',
                onPressed: () {
                  // if (nameFormKey.currentState!.validate()) {}
                  // if (emailFormKey.currentState!.validate()) {}
                  // if (passwordFormKey.currentState!.validate()) {}
                  // Get.to(() => LoginScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
