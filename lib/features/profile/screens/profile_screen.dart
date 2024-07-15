import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/features/profile/widgets/profile_tile_widget.dart';
import 'package:habitat54/features/update_property/controllers/update_sell_controller.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/controllers/session_controller.dart';
import 'package:habitat54/core/utils.dart';
import 'package:habitat54/features/dashboard/dashboard.dart';
import 'package:habitat54/features/profile/controllers/profile_controller.dart';
import 'package:habitat54/features/profile/screens/my_properties_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileC = Get.put(ProfileController());
  final updateSellC = Get.put(UpdateSellController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBarWidget(
          showTrailing: true,
          trailing: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => alertDialog(okPressed: () {
                  final sessionC = Get.find<SessionController>();
                  sessionC.assignSession('');
                  sessionC.assignVarification(false);
                  Get.offAll(() => DashBoard());
                }),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.grey),
              ),
              child: const Icon(
                Icons.logout_outlined,
                color: AppColors.grey,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () {
            return profileC.user.value != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        profileC.user.value!.image == null
                            ? Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                    color: AppColors.grey,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                              )
                            : Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      profileC.user.value!.image!,
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 12),
                        Text(
                          profileC.user.value!.name,
                          style: AppTextStyle.boldBlack16,
                        ),
                        const SizedBox(height: 20),
                        ProfileTileWidget(
                          icon: Icons.edit,
                          profileC: profileC,
                          title: 'Edit Profile',
                          onTap: () {
                            profileC.navigateToEditScreen(profileC.user.value!);
                          },
                        ),
                        ProfileTileWidget(
                          icon: Icons.home,
                          profileC: profileC,
                          title: 'My Properties',
                          onTap: () {
                            Get.to(
                              () => const MyPropertiesScreen(isRefresh: true),
                            );
                          },
                        ),
                        ProfileTileWidget(
                          icon: Icons.phone,
                          profileC: profileC,
                          title: 'Contact us',
                          onTap: () {
                            launchUrlWebsite("https://habitat54.com/contact/");
                          },
                        ),
                        ProfileTileWidget(
                          icon: Icons.info,
                          profileC: profileC,
                          title: 'About Us',
                          onTap: () {
                            launchUrlWebsite("https://habitat54.com/about-us/");
                          },
                        ),
                      ],
                    ),
                  )
                : const Loader();
          },
        ),
      ),
    );
  }
}
