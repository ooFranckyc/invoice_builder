import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/services/authentification.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
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
        Get.showSnackbar(GetSnackBar(
          backgroundColor: AppColors.cPrimary,
          message: 'Success, Welcome to Invoice Creator',
        ));
        break;
      default:
    }
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome, to Invoice Creator',
            style:
                TextStyle(color: AppColors.cPrimary, fontSize: 25.0, fontWeight: FontWeight.w700),
          ),
          AppBtn(
              label: 'Continue With Google',
              action: () async {
                bool success = await authProvider.handleSignIn();
                if (success) {
                  // push to home page
                }
              }),
          const Spacer(),
          authProvider.status == AuthentificationStatus.authentificating
              ? CircularProgressIndicator(
                  color: AppColors.cPrimary,
                )
              : const SizedBox.shrink()
        ],
      )),
    );
  }
}
