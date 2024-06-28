import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/features/sell/controllers/sell_controller.dart';
import 'package:habitat54/features/sell/screens/sell_step1.dart';
import 'package:habitat54/features/sell/screens/sell_step2.dart';
import 'package:habitat54/features/sell/screens/sell_step3.dart';
import 'package:habitat54/features/sell/screens/sell_step4.dart';
import 'package:habitat54/features/sell/widgets/sell_timeline.dart';

// ignore: must_be_immutable
class SellScreen extends StatelessWidget {
  SellScreen({super.key});

  static final sellC = Get.put(SellController());

  List pages = [
    SellStep1(sellC: sellC),
    SellStep2(sellC: sellC),
    SellStep3(sellC: sellC),
    SellStep4(sellC: sellC),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Obx(
                () => SellTimeLine(
                    step: sellC.pageIndex.value == 0
                        ? 1
                        : sellC.pageIndex.value + 1),
              )),
        ),
        body: Obx(
          () {
            print(sellC.pageIndex.value);
            return pages[sellC.pageIndex.value];
          },
        ),
      ),
    );
  }
}
