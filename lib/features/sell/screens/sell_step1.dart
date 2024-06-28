import 'package:flutter/material.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';
import 'package:habitat54/features/sell/controllers/sell_controller.dart';
import 'package:habitat54/features/sell/widgets/sell_textfield.dart';

class SellStep1 extends StatelessWidget {
  const SellStep1({super.key, required this.sellC});
  final SellController sellC;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: 185,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MaterialButton(
          onPressed: () {
            sellC.pageIndex(sellC.pageIndex.value + 1);
          },
          color: AppColors.primary,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue',
                style: AppTextStyle.mediumWhite14,
              ),
              SizedBox(width: 5),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SellTextField(
                label: 'Title',
              ),
              SellTextField(
                label: 'Description',
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
              SellTextField(
                label: 'Price',
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String>(
                  hint: Center(
                    child: const Text(
                      'Property Type',
                      style: TextStyle(
                          color: AppColors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                  style: AppTextStyle.mediumBlack16,
                  // value: 'Property Type', // Currently selected item
                  isExpanded:
                      true, // Make the dropdown button expand to full width
                  dropdownColor: Colors.white,

                  onChanged: (newValue) {},
                  underline: SizedBox(),
                  items:
                      ['Apartment', 'Villa', 'Office', 'Commercial Shop'].map(
                    (String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(item),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String>(
                  padding: EdgeInsets.only(right: 5),
                  hint: Center(
                    child: const Text(
                      'Offer Type',
                      style: TextStyle(
                          color: AppColors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                  style: AppTextStyle.mediumBlack16,
                  // value: 'Property Type', // Currently selected item
                  isExpanded:
                      true, // Make the dropdown button expand to full width
                  dropdownColor: Colors.white,
                  onChanged: (newValue) {},
                  underline: SizedBox(),
                  items: ['For Rent', 'For Sale'].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(item),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible: false,
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                              color: AppColors.grey,
                            ),
                            child: Text('data'),
                          ),
                          SizedBox(height: 5),
                          Icon(Icons.close)
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: 190,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        'Upload Image',
                        style: AppTextStyle.mediumWhite14,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
