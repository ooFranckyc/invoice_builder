import 'package:flutter/material.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:invoice_builder/shared/widgets/snackbar.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(
        title: 'Write Instructions',
        actions: [],
        showBackButton: true,
      ),
      backgroundColor: AppColors.cWhite,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (scroll) {
          scroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: AutoDimensions.calcH(5),
                horizontal: AutoDimensions.calcW(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Contact Us',
                    style: AppTextStyle.textStyle1(),
                  ),
                  AppText(
                    text:
                        'We send feedback or anything information about this app, please write you message in under box',
                    style: AppTextStyle.textStyle4(),
                    maxline: 3,
                    align: TextAlign.left,
                  ),
                  const SizedBox(height: 25),
                  Form(
                    child: Column(
                      children: [
                        AppTextFormField(
                          label: 'About you message',
                          height: AutoDimensions.calcH(100),
                          hint: 'Write you message here',
                          isRequired: true,
                          controller: messageController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.center,
                    child: AppBtn(
                      label: 'Send Message',
                      action: () {
                        if (messageController.value.text.isEmpty) {
                          messageWithSnackbar(
                              context: context, message: 'You can sent empty message');
                        }
                      },
                      color: AppColors.cPrimary,
                      textColor: AppColors.cWhite,
                      width: AutoDimensions.calcW(150),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
