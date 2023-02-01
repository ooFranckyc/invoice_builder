import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/shared/colors.dart';
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
            systemNavigationBarColor: AppColors.cWhite),
        backgroundColor: AppColors.cWhite,
        elevation: 0.0,
      ),
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        onFinish: () {
          Get.offAllNamed(AppLinks.registerScreen);
        },
        skipTextButton: const AppText(text: 'Skip'),
        trailing: GestureDetector(
            onTap: () {
              Get.offAllNamed(AppLinks.loginScreen);
              return;
            },
            child: const AppText(text: 'Login')),
        imageHorizontalOffset: MediaQuery.of(context).size.width / 6,
        imageVerticalOffset: MediaQuery.of(context).size.width / 6,
        finishButtonColor: AppColors.cPrimary,
        background: [
          SvgPicture.asset('assets/images/Invoice-pana.svg', width: 270, height: 270),
          SvgPicture.asset('assets/images/Invoice-cuate.svg', width: 270, height: 270),
          SvgPicture.asset('assets/images/Invoice-bro.svg', width: 270, height: 270),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 400,
                ),
                AppText(
                  text: 'Hola, no time to lose, ',
                  style: AppTextStyle.textStyle1(),
                ),
                const SizedBox(height: 5),
                AppText(
                  text:
                      'Invoice builder takes care of it, thanks to thousands of models, quickly build an invoice for your business.',
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
                  text: 'Better results with one click',
                  style: AppTextStyle.textStyle1(),
                ),
                const SizedBox(height: 5),
                AppText(
                  text:
                      'Surprise your customers with modern billing models with models built for your business.',
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
                  text: 'Powerfull in Desktop version',
                  maxline: 2,
                  style: AppTextStyle.textStyle1(),
                ),
                const SizedBox(height: 5),
                AppText(
                  text:
                      'Build the fast invoice with more details and precision, with the desktop version.',
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
