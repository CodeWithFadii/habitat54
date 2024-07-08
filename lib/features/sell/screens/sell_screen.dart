import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/features/profile/controllers/profile_controller.dart';
import 'package:habitat54/features/sell/controllers/sell_controller.dart';
import 'package:habitat54/features/sell/screens/sell_step1.dart';
import 'package:habitat54/features/sell/screens/sell_step2.dart';
import 'package:habitat54/features/sell/screens/sell_step3.dart';
import 'package:habitat54/features/sell/screens/sell_step4.dart';
import 'package:habitat54/features/sell/widgets/sell_timeline.dart';

// ignore: must_be_immutable
class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final profilec = Get.put(ProfileController());
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
              )),
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
