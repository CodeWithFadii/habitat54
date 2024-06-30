import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/core/constants/app_constants.dart';
import 'package:habitat54/features/auth/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;

  void navigateToAuthScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    navigateToAuthScreen();
    final height = MediaQuery.sizeOf(context).height * 1;
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
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: height * 0.2),
              child: const SizedBox(
                height: 27,
                width: 27,
                child: Loader(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
