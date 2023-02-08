import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/services/authentification.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/auth_button.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:invoice_builder/shared/widgets/snackbar.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthentificationProvider authProvider = Provider.of<AuthentificationProvider>(context);
    switch (authProvider.status) {
      case AuthentificationStatus.authentificateError:
        messageWithSnackbar(context: context, message: 'Authentification Failed');
        break;
      case AuthentificationStatus.authentificateCanceled:
        messageWithSnackbar(context: context, message: 'Autentification has canceled');
        break;
      case AuthentificationStatus.authentificated:
        break;
      default:
    }
    return Scaffold(
      appBar: invoiceBuildAppBar(
          elevation: 0.0,
          title: "",
          actions: [],
          backgroundColor: AppColors.dColor,
          showBackButton: false,
          sysUiBar: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: AppColors.dColor,
              systemNavigationBarColor: AppColors.dColor)),
      backgroundColor: AppColors.dColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get your free account',
                style: AppTextStyle.textStyle0(),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                'Sign up to use Invoice Builder for you bussiness',
                style: AppTextStyle.textStyle6(),
              ),
              const SizedBox(
                height: 30,
              ),
              Bounce(
                  duration: const Duration(milliseconds: 190),
                  onPressed: () async {
                    bool success = await authProvider.handleSignIn();
                    if (success) {
                      Get.offAndToNamed(AppLinks.homeScreen);
                    }
                  },
                  child: AuthButton(
                    title: 'Continue with Google',
                    iconAsImage: 'assets/google.png',
                    isFilled: true,
                    color: AppColors.cPrimary.withOpacity(.40),
                  )),
              const SizedBox(height: 10),
              Bounce(
                  duration: const Duration(milliseconds: 190),
                  onPressed: () async {
                    //Apple Sign In code
                  },
                  child: AuthButton(
                    title: 'Continue with Apple',
                    iconAsImage: 'assets/apple.png',
                    isFilled: true,
                    color: AppColors.cPrimary.withOpacity(.40),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AutoDimensions.calcH(15)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextFormField(
                            label: 'Email', hint: 'hola@outlook.com', controller: emailController),
                        AppTextFormField(
                            label: 'Password',
                            hint: 'Make you password',
                            controller: passwordController),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppLinks.loginScreen);
                          },
                          child: AppText(
                            text: 'Already account?',
                            style: AppTextStyle.textStyle4(
                              weight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Bounce(
                            duration: const Duration(milliseconds: 190),
                            onPressed: () async {
                              if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                                messageWithSnackbar(
                                    context: context, message: 'Please Complete your information');
                              }
                            },
                            child: const AuthButton(
                                title: 'Register', fontWeight: FontWeight.bold, isFilled: true))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
