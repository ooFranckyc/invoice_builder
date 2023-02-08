import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/customer_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:invoice_builder/shared/widgets/snackbar.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';

class CustomerInformationScreen extends StatefulWidget {
  const CustomerInformationScreen({super.key});

  @override
  State<CustomerInformationScreen> createState() => _CustomerInformationScreenState();
}

class _CustomerInformationScreenState extends State<CustomerInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(
        title: AppStrings.textTitleCustomerComposite,
        actions: [],
        showBackButton: true,
      ),
      backgroundColor: AppColors.cWhite,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (scroll) {
            scroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: GetBuilder<CustomerController>(
              init: CustomerController(),
              builder: (controller) => Container(
                margin: EdgeInsets.symmetric(
                  vertical: AutoDimensions.calcH(5),
                  horizontal: AutoDimensions.calcW(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Form(
                        child: Column(
                          children: [
                            AppTextFormField(
                              controller: controller.customerNameInputController,
                              label: AppStrings.textCustomerTitleNameComposite,
                              hint: AppStrings.textCustomerTitleNameHintComposite,
                              isRequired: true,
                            ),
                            AppTextFormField(
                              controller: controller.customerEmailInputController,
                              label: AppStrings.textCustomerTitleEmailComposite,
                              hint: AppStrings.textCustomerTitleEmailHintComposite,
                              isRequired: true,
                              type: TextInputType.emailAddress,
                            ),
                            AppTextFormField(
                              controller: controller.customerPhoneInputController,
                              label: AppStrings.textCustomerTitlePhoneNumberComposite,
                              hint: AppStrings.textCustomerTitlePhoneNumberHintComposite,
                              isRequired: true,
                              type: TextInputType.phone,
                            ),
                            AppTextFormField(
                              controller: controller.customerAddressInputController,
                              label: AppStrings.textCustomerTitleAddressComposite,
                              hint: AppStrings.textCustomerTitleAddressHintComposite,
                              height: AutoDimensions.calcH(100),
                              isRequired: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AutoDimensions.calcH(50),
                      ),
                      AppBtn(
                        label: AppStrings.textSaveBtn,
                        action: () {
                          bool isValid = controller.validate();
                          if (isValid) {
                            Get.back();
                          } else {
                            messageWithSnackbar(
                                context: context, message: AppStrings.customerErrorScreenText);
                          }
                        },
                        color: AppColors.cPrimary,
                        textColor: Colors.white,
                        width: AutoDimensions.calcW(150),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
