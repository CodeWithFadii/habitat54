import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/sell/controllers/sell_controller.dart';
import 'package:habitat54/features/sell/widgets/previous_next_button.dart';
import 'package:habitat54/features/sell/widgets/sell_textfield.dart';

class SellStep4 extends StatelessWidget {
  const SellStep4({super.key, required this.sellC});
  final SellController sellC;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PreviousNextButton(
        previous: () {
          sellC.pageIndex(sellC.pageIndex.value - 1);
        },
        next: () {
          // sellC.pageIndex(sellC.pageIndex.value + 1);
        },
        nextText: 'Submit',
      ),
      body: SafeArea(
        child: Column(
          children: [
            SellTextField(
              label: 'Add youtube video link',
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'Addional Features',
                style: AppTextStyle.boldBlack16,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SellTextField(
                    label: 'Name',
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: SellTextField(
                    label: 'Value',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Container(
              width: 190,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MaterialButton(
                onPressed: () {},
                color: AppColors.primary,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Add',
                      style: AppTextStyle.mediumWhite14,
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 220,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MaterialButton(
                onPressed: () {},
                color: AppColors.grey,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload_file,
                      color: AppColors.white,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Upload Attachment',
                      style: AppTextStyle.mediumWhite14,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
