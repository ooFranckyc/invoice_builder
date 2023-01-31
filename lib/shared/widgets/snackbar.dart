import 'package:flutter/material.dart';
import 'package:invoice_builder/shared/colors.dart';

void messageWithSnackbar({required BuildContext context, required String message, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color ?? AppColors.cPrimary.withOpacity(0.95),
      behavior: SnackBarBehavior.floating,
      content: Text(message)));
}
