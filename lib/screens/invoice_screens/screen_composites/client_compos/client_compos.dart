import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/client_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:invoice_builder/shared/widgets/snackbar.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';

class ClientInformationScreen extends StatefulWidget {
  const ClientInformationScreen({super.key});

  @override
  State<ClientInformationScreen> createState() => _ClientInformationScreenState();
}

class _ClientInformationScreenState extends State<ClientInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(
        title: 'Client(s)',
        actions: [],
        showBackButton: true,
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (scroll) {
            scroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: GetBuilder<ClientController>(
              init: ClientController(),
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
                              label: 'Full Name',
                              hint: 'Add Client Fullname',
                              isRequired: true,
                            ),
                            AppTextFormField(
                              controller: controller.customerEmailInputController,
                              label: 'Email',
                              hint: 'Add Client Email',
                              isRequired: true,
                              type: TextInputType.emailAddress,
                            ),
                            AppTextFormField(
                              controller: controller.customerPhoneInputController,
                              label: 'Phone',
                              hint: 'Client Phone Number',
                              isRequired: true,
                              type: TextInputType.phone,
                            ),
                            AppTextFormField(
                              controller: controller.customerAddressInputController,
                              label: 'Address',
                              hint: 'Client Location',
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
                        label: 'Save',
                        action: () {
                          bool isValid = controller.validate();
                          if (isValid) {
                            Get.back();
                          } else {
                            messageWithSnackbar(
                                context: context,
                                message:
                                    "Please Fill all the required fields for validate customers sections.");
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
