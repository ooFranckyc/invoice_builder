import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:invoice_builder/shared/colors.dart';

String title = "";
AppBar mainAppBar({required BuildContext context, required int index}) {
  if (index == 0) {
    title = 'Invoice Creator';
  } else if (index == 1) {
    title = 'Search Template';
  } else if (index == 2) {
    title = 'Recent Invoice';
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
          decoration: BoxDecoration(color: AppColors.cGreyLow, shape: BoxShape.circle),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          padding: const EdgeInsets.all(5.0),
          child: const Icon(Icons.menu)),
    ),
    centerTitle: true,
    title: Text(title),
    iconTheme: IconThemeData(
      color: AppColors.cPrimary,
    ),
    actions: [
      Bounce(
        duration: const Duration(milliseconds: 190),
        onPressed: () {},
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
