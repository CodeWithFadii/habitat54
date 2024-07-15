import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/utils.dart';
import 'package:habitat54/features/dashboard/dashboard.dart';
import 'package:habitat54/features/home/controllers/home_controller.dart';
import 'package:habitat54/features/profile/controllers/profile_controller.dart';
import 'package:habitat54/features/property/models/property.dart';
import 'package:habitat54/features/property/screens/property_details.dart';
import 'package:habitat54/features/update_property/controllers/update_sell_controller.dart';

class MyPropertiesScreen extends StatefulWidget {
  const MyPropertiesScreen({super.key, required this.isRefresh});
  final bool isRefresh;

  @override
  State<MyPropertiesScreen> createState() => _MyPropertiesScreenState();
}

class _MyPropertiesScreenState extends State<MyPropertiesScreen> {
  final exampleImage =
      'https://habitat54.com/wp-content/uploads/2024/05/0-2.jpeg';

  final profileC = Get.put(ProfileController());
  final homeC = Get.put(HomeController());
  final updateC = Get.put(UpdateSellController());

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.7), // Shadow color
                spreadRadius: 0.1, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(5,
                    0), // Offset in the vertical direction (negative for top shadow)
              ),
            ],
          ),
          child: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.offAll(() => DashBoard());
              },
            ),
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: Text(
              'My Properties',
              style: AppTextStyle.boldBlack18,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Property>>(
        future: profileC.getMyProperties(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Loader()
              : snapshot.hasError
                  ? const Center(
                      child: Text(
                          '  Something went wrong, Please check your internet connection before try again'),
                    )
                  : snapshot.data!.isEmpty
                      ? const Center(
                          child: Text('No data available'),
                        )
                      : ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final property = snapshot.data![index];
                            List<String> featureList = [];
                            List<String> parseDataString() {
                              final dataString = property.features?.first ?? '';
                              if (dataString == '[[]]') {
                                [];
                              }
                              if (dataString.length < 4) {
                                return [];
                              }
                              String cleanedString = dataString.substring(
                                  2, dataString.length - 2);
                              List<String> list = cleanedString.split(',');
                              for (int i = 0; i < list.length; i++) {
                                list[i] = list[i].replaceAll('"', '').trim();
                              }
                              return list;
                            }

                            featureList = parseDataString();
                            print(property.uploadImage);
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => PropertyDetails(property: property));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                padding: const EdgeInsets.all(7),
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        width: 90,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                        imageUrl: property.uploadImage!,
                                        placeholder: (context, url) =>
                                            const Loader(),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          children: [
                                            Text(
                                              'Property Type: ',
                                              style: AppTextStyle.mediumBlack16
                                                  .copyWith(
                                                      color: AppColors.grey),
                                            ),
                                            Text(
                                              property.propertyType,
                                              style: AppTextStyle.mediumBlack16,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Wrap(
                                          children: [
                                            Text(
                                              'Price : ',
                                              style: AppTextStyle.mediumBlack16
                                                  .copyWith(
                                                      color: AppColors.grey),
                                            ),
                                            Text(
                                              'AED ${property.price}',
                                              style: AppTextStyle.mediumBlack16,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Wrap(
                                          children: [
                                            Text(
                                              'Uploaded : ',
                                              style: AppTextStyle.mediumBlack16
                                                  .copyWith(
                                                      color: AppColors.grey),
                                            ),
                                            Text(
                                              property.createdAt,
                                              style: AppTextStyle.mediumBlack16,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              final updateSellC = Get.put(
                                                  UpdateSellController());
                                              updateSellC.updatePropertyValues(
                                                  property, featureList);
                                            },
                                            child: const Icon(Icons.edit)),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => alertDialog(
                                                  okPressed: () {
                                                    homeC.deleteProperty(
                                                        property.id);
                                                    refresh();
                                                  },
                                                  message:
                                                      'Are you sure to delete this property ?'),
                                            );
                                          },
                                          child: Obx(
                                            () {
                                              return homeC.isLoading.value
                                                  ? const Loader()
                                                  : const Icon(
                                                      Icons.delete,
                                                      color: AppColors.primary,
                                                    );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
        },
      ),
    );
  }
}
