import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitat54/core/common/app_colors.dart';
import 'package:habitat54/core/common/app_textstyle.dart';
import 'package:habitat54/core/common/loader.dart';
import 'package:habitat54/features/auth/controllers/auth_controller.dart';
import 'package:habitat54/features/auth/widgets/auth_textfield.dart';
import 'package:habitat54/features/auth/widgets/long_button.dart';
import 'package:pinput/pinput.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final authC = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 70,
          leading: BackButton(
            onPressed: () {
              Get.back();
            },
            color: AppColors.black,
          ),
        ),
        body: SafeArea(
          child: Obx(
            () {
              return authC.isLoading.value
                  ? const Loader()
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Forgot Password',
                            style: AppTextStyle.boldBlack30.copyWith(
                                fontSize: 32, fontWeight: FontWeight.w900),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                AuthTextField(
                                  leadingIcon: Icons.email_outlined,
                                  formKey: formKey,
                                  validator: (value) {
                                    String? error = authC.emailValidator(value);
                                    return error;
                                  },
                                  text: 'Email',
                                  controller: authC.forgetPasswordC,
                                ),
                                const SizedBox(height: 55),
                                LongButton(
                                  text: 'SEND',
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      authC.resendCode(
                                          authC.forgetPasswordC.text,
                                          resetPassword: true);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class ChnagePasswordPinScreen extends StatefulWidget {
  const ChnagePasswordPinScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  // ignore: library_private_types_in_public_api
  _ChnagePasswordPinScreenState createState() =>
      _ChnagePasswordPinScreenState();
}

class _ChnagePasswordPinScreenState extends State<ChnagePasswordPinScreen> {
  TextEditingController? pinC;
  final authC = Get.find<AuthController>();
  final pinFormKey = GlobalKey<FormState>();
  Timer? _timer;
  int _start = 0;

  void startTimer() {
    authC.resendCode(widget.email);
    setState(() {
      _start = 60;
    });

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    pinC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pinC!.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.black),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Obx(() {
          return authC.isLoading.value
              ? const Loader()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification',
                      style: AppTextStyle.boldBlack30
                          .copyWith(fontSize: 36, fontWeight: FontWeight.w900),
                    ),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            'Enter the code sent to the email',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.email,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Form(
                            key: pinFormKey,
                            child: Pinput(
                              controller: pinC,
                              validator: (value) {
                                if (value!.length < 4) {
                                  return 'Enter code to continue';
                                }
                                return null;
                              },
                              onTapOutside: (event) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 2,
                                      height: 24,
                                      color: AppColors
                                          .black // Change this to the desired cursor color
                                      ),
                                ],
                              ),
                              showCursor: true,
                              length: 4,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  border: Border.all(color: AppColors.black),
                                ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              pinAnimationType: PinAnimationType.fade,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _start == 0
                              ? TextButton(
                                  onPressed: () {
                                    startTimer();
                                    // Resend code logic here
                                  },
                                  child: const Text(
                                    "Didn't receive code? Resend",
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                )
                              : Text(
                                  "Try again after $_start seconds",
                                  style:
                                      const TextStyle(color: AppColors.primary),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(),
                    LongButton(
                        onPressed: () {
                          if (pinFormKey.currentState!.validate()) {
                            authC.verifyCode(pinC!.text.toString(), true,
                                email: widget.email);
                          }
                        },
                        text: 'Verify Email')
                  ],
                );
        }),
      ),
    );
  }
}
