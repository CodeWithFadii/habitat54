import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_bar_widget.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/feature_product_card.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/common/property_card.dart';
import 'package:habitat54/features/home/controllers/home_controller.dart';
import 'package:habitat54/features/home/widgets/property_filter_widget.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/property/screens/properties_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

  final homeC = Get.put(HomeController());

  Future<void> _refreshProperties() async {
    setState(() {});
    homeC.propertyType.value = '';
    homeC.offerType.value = '';
    homeC.priceFrom.clear();
    homeC.priceTo.clear();
    homeC.city.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.white,
          onRefresh: _refreshProperties,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HomeCrousel(),
                FutureBuilder<List<Property>>(
                  future: homeC.getProperties(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Loader(),
                          )
                        : snapshot.hasError
                            ? const Center(
                                child:  Text(
                                    'Something went wrong, Please check your internet connection before try again'),
                              )
                            : snapshot.data!.isEmpty
                                ? const Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 90, bottom: 30),
                                      child: Text('No Properties available'),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      PropertyFilterWidget(
                                        homeC: homeC,
                                        propertyList: snapshot.data!,onApplyTap: () {
                      homeC.navigateToFilterScreen(snapshot.data);
                    },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'RECENTLY ADDED',
                                              style: AppTextStyle.boldBlack16
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ListView.builder(
                                        reverse: true,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.length > 5
                                            ? 5
                                            : snapshot.data!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final property =
                                              snapshot.data![index];
                                          return PropertyCard(
                                            exampleImage: exampleImage,
                                            property: property,
                                          );
                                        },
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => PropertiesScreen());
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: 100,
                                            color: AppColors.primary,
                                            child: Text(
                                              'View more',
                                              style: AppTextStyle.boldWhite16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'FEATURED',
                                              style: AppTextStyle.boldBlack16
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 256,
                                        child: ListView.builder(
                                          itemCount: snapshot.data!.length > 5
                                              ? 5
                                              : snapshot.data!.length,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final property =
                                                snapshot.data![index];
                                            return FeatureProductCard(
                                              exampleImage: exampleImage,
                                              property: property,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
