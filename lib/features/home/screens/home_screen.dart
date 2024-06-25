import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/property_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    height: 60,
                    width: 130,
                    color: AppColors.black,
                    child: Text(
                      'FEATURED',
                      style: AppTextStyle.boldWhite16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'RECENTLY ADDED',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 20),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PropertyCard(exampleImage: exampleImage);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
