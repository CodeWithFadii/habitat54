import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/show_map.dart';
import 'package:habitat54/features/sell/widgets/custom_dropdown.dart';
import 'package:habitat54/features/sell/widgets/previous_next_button.dart';
import 'package:habitat54/features/update_property/controllers/update_sell_controller.dart';

class UpdateSellStep2 extends StatelessWidget {
  const UpdateSellStep2({super.key, required this.sellC});
  final UpdateSellController sellC;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PreviousNextButton(
        previous: () {
          sellC.pageIndex(sellC.pageIndex.value - 1);
        },
        next: () {
          sellC.step2Validator();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ShowMap(cityName: sellC.city.value),
                ),
                CustomDropDown(
                  title: 'City',
                  itemsList: sellC.cityList.isNotEmpty
                      ? sellC.cityList
                      : ['Abu Dhabi', 'Sharjah', 'Dubai', 'Ajman'],
                  onChanged: (value) {
                    sellC.city.value = value!;
                  },
                  value: sellC.city.value,
                  error: sellC.step2Validate.value
                      ? sellC.city.value.isNotEmpty
                          ? false
                          : true
                      : false,
                ),
                CustomDropDown(
                  title: 'Neighborhood',
                  itemsList: sellC.neighborhoodList.isNotEmpty
                      ? sellC.neighborhoodList
                      : [
                          "Downtown Dubai",
                          "Dubai Marina",
                          "Jumeirah",
                          "Deira",
                          "Business Bay"
                        ],
                  onChanged: (value) {
                    sellC.neighborhood.value = value!;
                  },
                  value: sellC.neighborhood.value,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
