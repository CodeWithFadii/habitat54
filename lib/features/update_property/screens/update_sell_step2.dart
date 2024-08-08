import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/neighborhood_delegate.dart';
import 'package:habitat54/core/common/neighborhood_select_widget.dart';
import 'package:habitat54/core/common/show_map.dart';
import 'package:habitat54/features/sell/widgets/custom_dropdown.dart';
import 'package:habitat54/features/sell/widgets/previous_next_button.dart';
import 'package:habitat54/features/update_property/controllers/update_sell_controller.dart';

class UpdateSellStep2 extends StatelessWidget {
  UpdateSellStep2({
    super.key,
  });
  final sellC = Get.find<UpdateSellController>();
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
          child: Obx(
            () {
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
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
                  NeighborhoodSelectWidget(
                    onPressed: () async {
                      final String selected = await showSearch(
                        context: context,
                        delegate: NeighborhoodDelegate(
                            neighborhoodList: sellC.neighborhoodList),
                      );
                      if (selected.isNotEmpty) {
                        sellC.neighborhood.value = selected;
                      }
                    },
                    neighborhood: sellC.neighborhood.value,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
