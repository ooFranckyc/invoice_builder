// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class OptionView extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool showArrow;
  final bool isComplete;
  final Function() onTap;
  const OptionView({
    required this.title,
    required this.onTap,
    this.subTitle,
    this.showArrow = true,
    this.isComplete = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (!showArrow || isComplete) ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        padding: const EdgeInsets.all(15.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: isComplete
                ? Border.all(width: 0.0, color: AppColors.cTransparent)
                : Border.all(width: 1.55, color: AppColors.cPrimary.withOpacity(.70)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: title,
                  align: TextAlign.left,
                  style: AppTextStyle.textStyle4(weight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                AppText(
                  text: subTitle ?? "",
                  align: TextAlign.left,
                  color: AppColors.cPrimary.withOpacity(.30),
                  style: AppTextStyle.textStyle5(weight: FontWeight.normal),
                ),
              ],
            )),
            (showArrow)
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.cGreyConcentric.withOpacity(.70),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Icon(Icons.arrow_right_alt, color: AppColors.cPrimary, size: 25),
                  )
                : const Text(''),
            (isComplete && !showArrow)
                ? Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Expanded(
                        child: SvgPicture.asset(
                          "assets/images/success_circle.svg",
                          height: 25,
                          color: Colors.green[600],
                        ),
                      ),
                    ),
                  )
                : const Text(""),
          ],
        ),
      ),
    );
  }
}
