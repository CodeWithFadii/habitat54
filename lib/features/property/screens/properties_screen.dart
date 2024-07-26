import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/common/property_card.dart';
import 'package:habitat54/features/home/controllers/home_controller.dart';
import 'package:habitat54/features/home/widgets/property_filter_widget.dart';
import 'package:habitat54/features/property/models/property.dart';

class PropertiesScreen extends StatelessWidget {
  PropertiesScreen({
    super.key,
  });

  final homeC = Get.put(HomeController());
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(
          showTrailing: false,
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Property>>(
          future: homeC.getProperties(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Loader(),
                  )
                : snapshot.hasError
                    ? const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                              'Something went wrong, Please check your internet connection before try again'),
                        ),
                      )
                    : snapshot.data!.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text('No Properties available'),
                            ),
                          )
                        : Column(
                            children: [
                              PropertyFilterWidget(
                                homeC: homeC,
                                propertyList: snapshot.data!,
                                onApplyTap: () {
                                  homeC.navigateToFilterScreen(snapshot.data);
                                },
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final property = snapshot.data![index];
                                  return PropertyCard(
                                    exampleImage: exampleImage,
                                    property: property,
                                  );
                                },
                              ),
                            ],
                          );
          },
        ),
      ),
    );
  }
}
