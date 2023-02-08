import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';

String title = "";
AppBar mainAppBar({required BuildContext context, required int index}) {
  if (index == 0) {
    title = 'Invoice Builder';
  } else if (index == 1) {
    title = 'Search Template';
  } else if (index == 2) {
    title = 'History Invoice';
  } else if (index == 3) {
    title = 'Profile';
  }
  return AppBar(
    elevation: 0,
    backgroundColor: AppColors.cWhite,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: AppColors.cWhite,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.cWhite,
    ),
    leading: Bounce(
      duration: const Duration(milliseconds: 190),
      onPressed: () => ZoomDrawer.of(context)!.toggle(),
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.cTransparent, shape: BoxShape.circle),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          padding: const EdgeInsets.all(5.0),
          child: const Icon(Icons.menu)),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: AppTextStyle.textStyle2(),
    ),
    iconTheme: IconThemeData(
      color: AppColors.cPrimary,
    ),
    actions: [
      Bounce(
        duration: const Duration(milliseconds: 190),
        onPressed: () {
          Get.toNamed(AppLinks.notificationScreen);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            CupertinoIcons.bell_fill,
            color: AppColors.cPrimary.withOpacity(.70),
          ),
        ),
      )
    ],
    titleTextStyle: TextStyle(color: AppColors.cPrimary, fontSize: 18, fontWeight: FontWeight.bold),
  );
}
