import 'package:flutter/cupertino.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';

class AppTextStyle {
  static TextStyle textStyleDefaultSystemValue({Color? color, FontStyle? style}) => TextStyle(
      fontFamily: AppStrings.fontName,
      color: color ?? AppColors.cPrimary,
      fontStyle: style ?? FontStyle.normal);

  static TextStyle textStyle0({Color? color, FontStyle? style}) => TextStyle(
      fontFamily: AppStrings.fontName,
      fontSize: AutoDimensions.calcH(35),
      color: color ?? AppColors.cPrimary,
      fontWeight: FontWeight.w700,
      fontStyle: style ?? FontStyle.normal);

  static TextStyle textStyle1({Color? color, FontStyle? style}) => TextStyle(
      fontFamily: AppStrings.fontName,
      fontSize: AutoDimensions.calcH(25),
      color: color ?? AppColors.cPrimary,
      fontWeight: FontWeight.w700,
      fontStyle: style ?? FontStyle.normal);

  static TextStyle textStyle2({Color? color, FontStyle? style}) => TextStyle(
      fontFamily: AppStrings.fontName,
      fontSize: AutoDimensions.calcH(20),
      color: color ?? AppColors.cPrimary,
      fontWeight: FontWeight.w600,
      fontStyle: style ?? FontStyle.normal);

  static TextStyle textStyle3({Color? color, FontStyle? style}) => TextStyle(
      fontFamily: AppStrings.fontName,
      fontSize: AutoDimensions.calcH(18),
      color: color ?? AppColors.cPrimary,
      fontWeight: FontWeight.w600,
      fontStyle: style ?? FontStyle.normal);

  static TextStyle textStyle4({Color? color, FontStyle? style, FontWeight? weight}) => TextStyle(
      fontFamily: AppStrings.fontName,
      fontSize: AutoDimensions.calcH(17),
      color: color ?? AppColors.cPrimary,
      fontWeight: weight ?? FontWeight.normal,
      fontStyle: style ?? FontStyle.normal);

  static TextStyle textStyle5({Color? color, FontStyle? style, FontWeight? weight}) => TextStyle(
      fontFamily: AppStrings.fontName,
      fontSize: AutoDimensions.calcH(16),
      color: color ?? AppColors.cPrimary,
      fontWeight: weight ?? FontWeight.normal,
      fontStyle: style ?? FontStyle.normal);

  static TextStyle textStyle6({Color? color, FontStyle? style, FontWeight? weight}) => TextStyle(
      fontFamily: AppStrings.fontName,
      fontSize: AutoDimensions.calcH(14),
      color: color ?? AppColors.cPrimary,
      fontWeight: weight ?? FontWeight.normal,
      fontStyle: style ?? FontStyle.normal);

  static TextStyle textStyle7({Color? color, FontStyle? style, FontWeight? weight}) => TextStyle(
      fontFamily: AppStrings.fontName,
      fontSize: AutoDimensions.calcH(12),
      color: color ?? AppColors.cPrimary,
      fontWeight: weight ?? FontWeight.normal,
      fontStyle: style ?? FontStyle.normal);
}
