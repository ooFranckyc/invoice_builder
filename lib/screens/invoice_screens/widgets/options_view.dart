// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
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
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: title,
              align: TextAlign.left,
              style: AppTextStyle.textStyle3(weight: FontWeight.w800, color: AppColors.cPrimary),
            ),
            const Spacer(),
            (showArrow)
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.cGreyConcentric.withOpacity(.30),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Icon(Icons.arrow_right_alt, color: AppColors.cPrimary, size: 25),
                  )
                : const Text(''),
            (isComplete && !showArrow)
                ? Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        AppStrings.doneArgumentIcons,
                        height: 25,
                        width: 25,
                        color: Colors.green[600],
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
