import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice_builder/shared/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
    );
  }
}
