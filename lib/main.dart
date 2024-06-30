import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:get/get.dart';
import 'package:habitat54/features/auth/screens/splash_screen.dart';
import 'package:habitat54/features/dashboard/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Habitat54',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          appBarTheme: const AppBarTheme(
            color: AppColors.white,
          ),
        ),
        // home: SplashScreen(),
        home: const DashBoard());
  }
}
