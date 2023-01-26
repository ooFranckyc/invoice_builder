import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';

class PaymentInstructionsScreen extends GetView<InvoiceController> {
  PaymentInstructionsScreen({Key? key}) : super(key: key);
  final TextEditingController _paymentInstInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (scroll) {
        scroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: AutoDimensions.calcH(5),
            horizontal: AutoDimensions.calcW(15),
          ),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    AppTextFormField(
                      controller: _paymentInstInputController,
                      label: 'Write your instructions',
                      height: AutoDimensions.calcH(100),
                      isRequired: true,
                    ),
                  ],
                ),
              ),
              AppBtn(
                label: 'Save Instructions',
                action: () {
                  if (_paymentInstInputController.text.isEmpty ||
                      _paymentInstInputController.text.length < 5) {
                    Get.snackbar("Error", "Please check your entries and try again!",
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    controller.setPaymentInstructions(_paymentInstInputController.text);
                    Get.close(1);
                  }
                },
                color: AppColors.cPrimary,
                textColor: AppColors.cWhite,
                width: AutoDimensions.calcW(150),
              )
            ],
          ),
        ),
      ),
    );
  }
}
