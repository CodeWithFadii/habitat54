import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/core/controllers/session_controller.dart';
import 'package:habitat54/features/auth/screens/login_screen.dart';
import 'package:habitat54/features/dashboard/dashboard_controller.dart';
import 'package:habitat54/features/dashboard/dashboard_navitem.dart';
import 'package:habitat54/features/home/screens/home_screen.dart';
import 'package:habitat54/features/profile/screens/guest_screen.dart';
import 'package:habitat54/features/profile/screens/profile_screen.dart';
import 'package:habitat54/features/property/screens/properties_screen.dart';
import 'package:habitat54/features/sell/screens/sell_screen.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key, this.index});
  final DashboardController dashboardC = Get.put(DashboardController());
  final SessionController sessionC = Get.find<SessionController>();
  final int? index;
  final List<Widget> pages = [
    const HomeScreen(),
    PropertiesScreen(),
    Obx(() => Get.find<SessionController>().id.value.isNotEmpty
        ? const SellScreen()
        : LoginScreen()),
    Obx(() => Get.find<SessionController>().id.value.isNotEmpty
        ? ProfileScreen()
        : const GuestScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (index != null) {
      dashboardC.index.value = 3;
    }
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: pages[dashboardC.index.value],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: width,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.3),
                spreadRadius: 0.1,
                blurRadius: 1,
                offset: const Offset(0, -0.1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DashboardNavItem(
                text: 'Home',
                icon: AppConstants.home,
                isActive: dashboardC.index.value == 0,
                onTap: () => dashboardC.index.value = 0,
              ),
              DashboardNavItem(
                text: 'Buy',
                icon: AppConstants.buy,
                isActive: dashboardC.index.value == 1,
                onTap: () => dashboardC.index.value = 1,
              ),
              DashboardNavItem(
                text: 'Sell',
                icon: AppConstants.sell,
                isActive: dashboardC.index.value == 2,
                onTap: () => dashboardC.index.value = 2,
              ),
              DashboardNavItem(
                text: 'Profile',
                icon: AppConstants.profile,
                isActive: dashboardC.index.value == 3,
                onTap: () => dashboardC.index.value = 3,
              ),
            ],
          ),
        ),
      );
    });
  }
}
