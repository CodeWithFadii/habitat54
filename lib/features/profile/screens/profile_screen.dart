import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/back_button_widget.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/core/utils.dart';
import 'package:habitat54/features/profile/screens/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(
          trailing: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => alertDialog(),
              );
            },
            child: BackButtonWidget(
              icon: Icons.logout_outlined,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  AppConstants.facebook,
                ),
                radius: 30,
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 10,
                children: [
                  Text(
                    'Fahad Ali'.toLowerCase(),
                    style: AppTextStyle.boldBlack14,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() =>  EditProfileScreen());
                    },
                    child: Icon(
                      Icons.edit,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      // Get.offAll(() => LoginScreen());
                    },
                    color: AppColors.primary,
                    elevation: 0,
                    height: 38,
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: AppColors.white,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '123456789',
                          style: AppTextStyle.mediumWhite12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  MaterialButton(
                    onPressed: () {
                      // Get.offAll(() => LoginScreen());
                    },
                    color: AppColors.white,
                    elevation: 6,
                    height: 38,
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.message_outlined,
                          color: AppColors.black,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Send Message',
                          style: AppTextStyle.mediumBlack12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'My Properties',
                style: AppTextStyle.boldBlack18,
              ),
              SizedBox(height: 12),
              Divider(),
              SizedBox(height: 12),
              SizedBox(height: 22),
              Text(
                'My Favourites',
                style: AppTextStyle.boldBlack18,
              ),
              SizedBox(height: 12),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
