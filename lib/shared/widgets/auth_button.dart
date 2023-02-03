import 'package:flutter/material.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final String? iconAsImage;
  final bool isFilled;
  final Color? color;
  final FontWeight? fontWeight;
  final Color? textColor;
  final EdgeInsets? horizontalMargin;
  const AuthButton(
      {super.key,
      required this.title,
      this.iconAsImage,
      required this.isFilled,
      this.horizontalMargin,
      this.textColor,
      this.fontWeight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AutoDimensions.calcH(60),
      padding: const EdgeInsets.all(15.0),
      margin: horizontalMargin ?? const EdgeInsets.symmetric(),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
          color: isFilled ? color ?? AppColors.cPrimary.withOpacity(.80) : AppColors.cWhite,
          //border: Border.all(width: .5, color: AppColors.cPrimary),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconAsImage == null)
            const SizedBox()
          else
            Image.asset(iconAsImage!, width: 40, height: 40),
          const SizedBox(width: 5),
          Text(
            title,
            style: AppTextStyle.textStyle5(
                weight: fontWeight ?? FontWeight.normal,
                color: isFilled ? AppColors.cWhite : textColor ?? AppColors.cPrimary),
          )
        ],
      ),
    );
  }
}
