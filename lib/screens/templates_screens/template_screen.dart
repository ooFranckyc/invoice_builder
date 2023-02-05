import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
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
          text: 'Find template',
          style: AppTextStyle.textStyle3(color: AppColors.cPrimary),
        ),
      ),
      backgroundColor: AppColors.cWhite,
    );
  }
}
