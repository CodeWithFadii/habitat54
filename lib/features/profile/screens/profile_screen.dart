import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/back_button_widget.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/core/utils.dart';
import 'package:habitat54/features/profile/screens/edit_profile_screen.dart';
import 'package:habitat54/features/profile/screens/myproperties.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(
          showTrailing: true,
          trailing: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => alertDialog(),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.grey),
              ),
              child: Icon(
                Icons.logout_outlined,
                color: AppColors.grey,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
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
              Text(
                'Fahad Ali'.toLowerCase(),
                style: AppTextStyle.boldBlack14,
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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: ListTile(
                  minLeadingWidth: 1,
                  minTileHeight: 30,
                  leading: Icon(
                    Icons.edit,
                    size: 18,
                    color: AppColors.black,
                  ),
                  title: Text(
                    'Edit Profile',
                    style: AppTextStyle.boldBlack16,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Get.to(() => EditProfileScreen());
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: ListTile(
                  minTileHeight: 30,
                  minLeadingWidth: 1,
                  leading: Icon(
                    Icons.home,
                    size: 20,
                    color: AppColors.black,
                  ),
                  title: Text(
                    'My Properties',
                    style: AppTextStyle.boldBlack16,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Get.to(() => Myproperties());
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black,
                      size: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
