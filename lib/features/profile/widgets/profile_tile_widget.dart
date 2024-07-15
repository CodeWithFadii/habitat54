
import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/profile/controllers/profile_controller.dart';

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget({
    super.key,
    required this.profileC,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  final ProfileController profileC;
  final String title;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          minLeadingWidth: 1,
          minTileHeight: 30,
          leading: Icon(
            icon,
            size: 20,
            color: AppColors.black,
          ),
          title: Text(
            title,
            style: AppTextStyle.boldBlack16,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.black,
            size: 18,
          ),
        ),
      ),
    );
  }
}
