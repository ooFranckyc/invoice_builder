import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/services/authentification.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      _checkUserSignIn();
    });
    super.initState();
  }

  Future _checkUserSignIn() async {
    AuthentificationProvider authProvider = context.read<AuthentificationProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Get.offAndToNamed(AppLinks.homeScreen);
      return;
    } else {
      Get.offAndToNamed(AppLinks.onbordingScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cPrimary,
        appBar: AppBar(
            backgroundColor: AppColors.cPrimary,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              statusBarColor: AppColors.cPrimary,
              systemNavigationBarColor: AppColors.cPrimary,
              systemNavigationBarIconBrightness: Brightness.dark,
            )),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedTextKit(totalRepeatCount: 2, animatedTexts: [
              FadeAnimatedText('Invoice Builder',
                  duration: const Duration(milliseconds: 1500),
                  textStyle: AppTextStyle.textStyle1(color: AppColors.cWhite))
            ]),
          ],
        )));
  }
}
