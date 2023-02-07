import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(title: 'Notifications', actions: [], showBackButton: true),
      backgroundColor: AppColors.cWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.bell_fill, size: 30, color: AppColors.cPrimary.withOpacity(.80)),
            const SizedBox(height: 10),
            Text('No Notification', style: AppTextStyle.textStyle2())
          ],
        ),
      ),
    );
  }
}
