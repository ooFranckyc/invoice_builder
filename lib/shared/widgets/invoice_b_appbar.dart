import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';

Duration defaultDuration = const Duration(milliseconds: 180);
AppBar invoiceBuildAppBar(
    {required String title,
    required List<Widget> actions,
    required bool showBackButton,
    double? elevation,
    Color? backgroundColor,
    SystemUiOverlayStyle? sysUiBar}) {
  return AppBar(
    elevation: elevation ?? .5,
    backgroundColor: backgroundColor ?? AppColors.cWhite,
    automaticallyImplyLeading: false,
    leading: showBackButton
        ? Bounce(
            duration: defaultDuration,
            onPressed: () {
              Get.back();
            },
            child: Container(
                alignment: Alignment.center,
                // decoration: BoxDecoration(color: AppColors.cGreyLow, shape: BoxShape.circle),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.arrow_back, color: AppColors.cPrimary)),
          )
        : null,
    centerTitle: true,
    title: Text(title, style: AppTextStyle.textStyle3()),
    systemOverlayStyle: sysUiBar ??
        SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: AppColors.cWhite,
        ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: actions,
        ),
      )
    ],
  );
}
