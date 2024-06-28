import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/property_card.dart';

class Myproperties extends StatelessWidget {
  const Myproperties({super.key});
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

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
              'My Properties',
              style: AppTextStyle.boldBlack18,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return PropertyCard(exampleImage: exampleImage);
        },
      ),
    );
  }
}
