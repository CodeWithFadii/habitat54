import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/features/dashboard/dashboard_navitem.dart';
import 'package:habitat54/features/home/screens/home_screen.dart';
import 'package:habitat54/features/profile/screens/guest_screen.dart';
import 'package:habitat54/features/profile/screens/profile_screen.dart';
import 'package:habitat54/features/property/screens/properties_screen.dart';
import 'package:habitat54/features/sell/screens/sell_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int index = 0;
  List pages = [
    HomeScreen(),
    PropertiesScreen(),
    SellScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: width,
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.3), // Shadow color
              spreadRadius: 0.1, // Spread radius
              blurRadius: 1, // Blur radius
              offset: const Offset(0,
                  -0.1), // Offset in the vertical direction (negative for top shadow)
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DashboardNavItem(
              text: '   Home  ',
              icon: AppConstants.home,
              isActive: index == 0 ? true : false,
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
            ),
            DashboardNavItem(
              text: '   Buy  ',
              icon: AppConstants.buy,
              isActive: index == 1 ? true : false,
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
            ),
            DashboardNavItem(
              text: '   Sell   ',
              icon: AppConstants.sell,
              isActive: index == 2 ? true : false,
              onTap: () {
                setState(() {
                  index = 2;
                });
              },
            ),
            DashboardNavItem(
              text: 'Profile',
              icon: AppConstants.profile,
              isActive: index == 3 ? true : false,
              onTap: () {
                setState(() {
                  index = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
