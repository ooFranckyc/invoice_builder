import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.cWhite,
            systemNavigationBarColor: AppColors.dColor),
        backgroundColor: AppColors.cWhite,
        elevation: 0.0,
      ),
      backgroundColor: AppColors.cWhite,
      body: OnBoardingSlider(
        headerBackgroundColor: AppColors.cWhite,
        pageBackgroundColor: AppColors.cWhite,
        finishButtonText: AppStrings.textRegisterOnbordingScreen,
        onFinish: () {
          Get.offAllNamed(AppLinks.registerScreen);
        },
        skipTextButton: AppText(text: AppStrings.textSkipOnbordingScreen),
        trailing: GestureDetector(
            onTap: () {
              Get.offAllNamed(AppLinks.loginScreen);
              return;
            },
            child: AppText(text: AppStrings.textLoginBtn)),
        imageHorizontalOffset: MediaQuery.of(context).size.width / 6,
        imageVerticalOffset: MediaQuery.of(context).size.width / 6,
        finishButtonColor: AppColors.cPrimary,
        background: [
          SvgPicture.asset(
            AppStrings.onBordingInvoiceI,
            width: 270,
            height: 270,
          ),
          SvgPicture.asset(AppStrings.onBordingInvoiceII, width: 270, height: 270),
          SvgPicture.asset(AppStrings.onBordingInvoiceIII, width: 270, height: 270),
        ],
        totalPage: 3,
        speed: 1.8,
        controllerColor: AppColors.cPrimary,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 400,
                ),
                AppText(
                  text: AppStrings.textTitleOnbordingIScreen,
                  style: AppTextStyle.textStyle1(),
                ),
                const SizedBox(height: 5),
                AppText(
                  text: AppStrings.textDescOnbordingIScreen,
                  maxline: 3,
                  style: AppTextStyle.textStyle4(color: AppColors.cPrimary.withOpacity(.70)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 400,
                ),
                AppText(
                  text: AppStrings.textTitleOnbordingIIScreen,
                  style: AppTextStyle.textStyle1(),
                ),
                const SizedBox(height: 5),
                AppText(
                  text: AppStrings.textDescOnbordingIIScreen,
                  maxline: 3,
                  style: AppTextStyle.textStyle4(color: AppColors.cPrimary.withOpacity(.70)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 400,
                ),
                AppText(
                  text: AppStrings.textTitleOnbordingIIIScreen,
                  maxline: 2,
                  style: AppTextStyle.textStyle1(),
                ),
                const SizedBox(height: 5),
                AppText(
                  text: AppStrings.textDescOnbordingIIIScreen,
                  maxline: 3,
                  style: AppTextStyle.textStyle4(color: AppColors.cPrimary.withOpacity(.70)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
