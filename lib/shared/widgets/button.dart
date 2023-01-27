// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class AppBtn extends StatelessWidget {
  final String label;
  final Function() action;
  Color? color;
  Color? textColor;
  double? width;
  AppBtn({
    required this.label,
    required this.action,
    this.color,
    this.width,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStatePropertyAll<Color>(color ?? Colors.white),
          elevation: const MaterialStatePropertyAll<double?>(0.0),
          padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 30))),
      onPressed: action,
      child: AppText(
        text: label,
        color: textColor ?? AppColors.cPrimary,
      ),
    );
  }
}
