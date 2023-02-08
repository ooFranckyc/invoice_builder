// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/rich_text.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final String label;
  final String? hint;
  final bool isRequired;
  final double? height;
  final TextStyle? style;
  final Color? fillColor;
  const AppTextFormField({
    required this.label,
    required this.controller,
    this.hint,
    this.type,
    this.height,
    this.isRequired = false,
    this.style,
    this.fillColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AutoDimensions.calcH(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRichText(
            text: label,
            style: style ?? AppTextStyle.textStyle3(),
            children: (isRequired)
                ? [
                    TextSpan(
                      text: " *",
                      style: TextStyle(
                        color: Colors.red.shade800,
                      ),
                    ),
                  ]
                : [],
          ),
          SizedBox(
            height: AutoDimensions.calcH(8),
          ),
          Container(
            color: AppColors.cGreyLow,
            height: height,
            margin: EdgeInsets.only(
              right: AutoDimensions.calcW(5),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: type,
              decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  fillColor: fillColor ?? const Color(0xfff5f5f5),
                  filled: true),
            ),
          )
        ],
      ),
    );
  }
}
