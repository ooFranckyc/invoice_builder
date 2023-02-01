import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/services/authentification.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthentificationProvider authProvider = Provider.of<AuthentificationProvider>(context);
    switch (authProvider.status) {
      case AuthentificationStatus.authentificateError:
        Get.showSnackbar(GetSnackBar(
          backgroundColor: AppColors.cPrimary,
          message: 'Failed Autentification',
        ));
        break;
      case AuthentificationStatus.authentificateCanceled:
        Get.showSnackbar(GetSnackBar(
          backgroundColor: AppColors.cPrimary,
          message: 'Autentification has canceled',
        ));
        break;
      case AuthentificationStatus.authentificated:
        //notify user
        break;
      default:
    }
    return Scaffold(
      appBar: invoiceBuildAppBar(
          elevation: 0.0,
          title: "",
          actions: [
            GestureDetector(
                onTap: () {
                  exit(123); // ! Close authentificarion session with code 123
                },
                child: const Icon(Icons.close))
          ],
          showBackButton: false,
          sysUiBar: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: AppColors.cWhite,
              systemNavigationBarColor: AppColors.cWhite)),
      backgroundColor: AppColors.cWhite,
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: AutoDimensions.calcH(28.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome !',
                style: AppTextStyle.textStyle0(),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                'Easy, Efficient and Productive.',
                style: AppTextStyle.textStyle6(),
              ),
              const SizedBox(height: 10),
              Text(
                'Invoice creator allows you to build different invoices in a professional way with thousands of free templates. Log in and build invoices for your customers.',
                style: AppTextStyle.textStyle5(color: AppColors.cPrimary.withOpacity(.70)),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: AutoDimensions.calcH(15)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextFormField(
                        label: 'Email', hint: 'hello@outlook.com', controller: emailController),
                    AppTextFormField(
                        label: 'Password', hint: 'You password', controller: passwordController),
                    AppText(
                      text: 'Forgot password?',
                      style: AppTextStyle.textStyle4(weight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    Bounce(
                      duration: const Duration(milliseconds: 190),
                      onPressed: () async {},
                      child: Container(
                        height: AutoDimensions.calcH(60),
                        padding: const EdgeInsets.all(15.0),
                        margin: EdgeInsets.symmetric(horizontal: AutoDimensions.calcW(25)),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.cPrimary, borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          'Login',
                          style: AppTextStyle.textStyle3(
                              weight: FontWeight.w600, color: AppColors.cWhite),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Or',
                    style: AppTextStyle.textStyle4(weight: FontWeight.w700),
                  )),
              Bounce(
                duration: const Duration(milliseconds: 190),
                onPressed: () async {
                  bool success = await authProvider.handleSignIn();
                  if (success) {
                    Get.offAndToNamed(AppLinks.homeScreen);
                  }
                },
                child: Container(
                  height: AutoDimensions.calcH(60),
                  padding: const EdgeInsets.all(15.0),
                  margin: EdgeInsets.symmetric(horizontal: AutoDimensions.calcW(60)),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.cWhite,
                      //border: Border.all(width: .5, color: AppColors.cPrimary),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/google.png', width: 40, height: 40),
                      const SizedBox(width: 5),
                      Text(
                        'Continue with Google',
                        style: AppTextStyle.textStyle5(weight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Bounce(
                duration: const Duration(milliseconds: 190),
                onPressed: () async {
                  //Apple Sign In code
                },
                child: Container(
                  height: AutoDimensions.calcH(60),
                  padding: const EdgeInsets.all(15.0),
                  margin: EdgeInsets.symmetric(horizontal: AutoDimensions.calcW(60)),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.cWhite,
                      //border: Border.all(width: .5, color: AppColors.cPrimary),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/apple.png', width: 40, height: 40),
                      const SizedBox(width: 5),
                      Text(
                        'Continue with Apple',
                        style: AppTextStyle.textStyle6(weight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
