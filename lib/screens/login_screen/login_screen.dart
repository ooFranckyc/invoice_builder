import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/services/authentification.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          actions: [],
          showBackButton: false,
          sysUiBar: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: AppColors.cWhite)),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: AutoDimensions.calcH(28.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome !',
                style: AppTextStyle.textStyle0(),
              ),
              Text(
                'Easy, Efficient and Productive.',
                style: AppTextStyle.textStyle7(),
              ),
              const SizedBox(height: 10),
              Text(
                'Invoice creator allows you to build different invoices in a professional way with thousands of free templates. Log in and build invoices for your customers.',
                style: AppTextStyle.textStyle6(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AutoDimensions.calcH(60)),
              Bounce(
                duration: const Duration(milliseconds: 190),
                onPressed: () async {
                  bool success = await authProvider.handleSignIn();
                  if (success) {
                    Get.offAndToNamed('/home_screen');
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
                      border: Border.all(width: 1.55, color: AppColors.cPrimary),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/google.png', width: 40, height: 40),
                      Text(
                        'Continue With Google',
                        style: AppTextStyle.textStyle6(weight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Or',
                    style: AppTextStyle.textStyle4(weight: FontWeight.w700),
                  )),
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
                      border: Border.all(width: 1.55, color: AppColors.cPrimary),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/apple.png', width: 40, height: 40),
                      Text(
                        'Continue With Apple',
                        style: AppTextStyle.textStyle6(weight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              authProvider.status == AuthentificationStatus.authentificating
                  ? CircularProgressIndicator(
                      color: AppColors.cPrimary,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      )),
    );
  }
}
