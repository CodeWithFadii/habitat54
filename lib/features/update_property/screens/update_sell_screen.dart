import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/features/profile/controllers/profile_controller.dart';
import 'package:habitat54/features/sell/widgets/sell_timeline.dart';
import 'package:habitat54/features/update_property/controllers/update_sell_controller.dart';
import 'package:habitat54/features/update_property/screens/update_sell_step1.dart';
import 'package:habitat54/features/update_property/screens/update_sell_step2.dart';
import 'package:habitat54/features/update_property/screens/update_sell_step3.dart';
import 'package:habitat54/features/update_property/screens/update_sell_step4.dart';

// ignore: must_be_immutable
class UpdateSellScreen extends StatefulWidget {
  const UpdateSellScreen({super.key});

  @override
  State<UpdateSellScreen> createState() => _UpdateSellScreenState();
}

class _UpdateSellScreenState extends State<UpdateSellScreen> {
  final profilec = Get.put(ProfileController());
  static final sellC = Get.find<UpdateSellController>();
  List pages = [
    UpdateSellStep1(),
    UpdateSellStep2(),
    UpdateSellStep3(),
    UpdateSellStep4(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Obx(
              () => SellTimeLine(
                  step: sellC.pageIndex.value == 0
                      ? 1
                      : sellC.pageIndex.value + 1),
            ),
          ),
        ),
        body: Obx(
          () {
            return pages[sellC.pageIndex.value];
          },
        ),
      ),
    );
  }
}
