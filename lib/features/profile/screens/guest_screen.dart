import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/utils.dart';
import 'package:habitat54/features/auth/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  void launchUrlWebsite(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      // showCustomSnackbar('Something went wrong from our side');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(
          showTrailing: false,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi There',
                style: AppTextStyle.boldBlack20,
              ),
              const SizedBox(height: 12),
              Text(
                'Signin for more personalized experience',
                style:
                    AppTextStyle.regularBlack16.copyWith(color: AppColors.grey),
              ),
              const SizedBox(height: 12),
              MaterialButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                color: AppColors.primary,
                elevation: 0,
                height: 38,
                minWidth: 100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Sign in / Sign up',
                  style: AppTextStyle.mediumWhite16,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                'Support',
                style: AppTextStyle.boldBlack20,
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  launchUrlWebsite("https://habitat54.com/contact/");
                },
                child: const ProfileListTile(
                  title: 'Contact Us',
                  icon: Icons.phone_outlined,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  launchUrlWebsite("https://habitat54.com/about-us/");
                },
                child: const ProfileListTile(
                  title: 'About Us',
                  icon: Icons.info_outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          spacing: 9,
          children: [
            Icon(
              icon,
              color: AppColors.grey,
              size: 22,
            ),
            Text(
              title,
              style: AppTextStyle.mediumWhite16.copyWith(color: AppColors.grey),
            ),
          ],
        ),
        const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.grey,
          size: 22,
        ),
      ],
    );
  }
}
