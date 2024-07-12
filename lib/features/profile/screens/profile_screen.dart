import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
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
        child: Obx(() {
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            profileC.navigateToEditScreen(profileC.user.value!);
                          },
                          child: ListTile(
                            minLeadingWidth: 1,
                            minTileHeight: 30,
                            leading: const Icon(
                              Icons.edit,
                              size: 20,
                              color: AppColors.black,
                            ),
                            title: Text(
                              'Edit Profile',
                              style: AppTextStyle.boldBlack16,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.black,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const MyPropertiesScreen(
                                  isRefresh: false,
                                ));
                          },
                          child: ListTile(
                            minTileHeight: 30,
                            minLeadingWidth: 1,
                            leading: const Icon(
                              Icons.home,
                              size: 22,
                              color: AppColors.black,
                            ),
                            title: Text(
                              'My Properties',
                              style: AppTextStyle.boldBlack16,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.black,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const Loader();
        }),
      ),
    );
  }
}
