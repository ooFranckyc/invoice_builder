import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class LastTemplateUsedScreen extends StatefulWidget {
  const LastTemplateUsedScreen({super.key});

  @override
  State<LastTemplateUsedScreen> createState() => _LastTemplateUsedScreenState();
}

class _LastTemplateUsedScreenState extends State<LastTemplateUsedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cWhite,
        elevation: .0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.cWhite),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColors.cPrimary),
        title: AppText(
          text: 'You Templates',
          style: AppTextStyle.textStyle3(color: AppColors.cPrimary),
        ),
      ),
      backgroundColor: AppColors.cWhite,
    );
  }
}
