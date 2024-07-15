import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/core/controllers/connectivity_controller.dart';
import 'package:habitat54/core/controllers/session_controller.dart';
import 'package:habitat54/features/dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final internetC = Get.put(ConnectivityController(), permanent: true);
  final sessionC = Get.put(SessionController(), permanent: true);

  bool isLoading = true;

  void navigate() async {
    sessionC.checkSession();
    Future.delayed(const Duration(seconds: 2), () {
      if (internetC.connectionStatus.value) {
        Get.offAll(() => DashBoard());
      }
    });
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppConstants.logo, // Replace with your image asset path
                  height: 220,
                ),
                const SizedBox(height: 25),
                const Loader(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
