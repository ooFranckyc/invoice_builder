import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_builder/controllers/business_ctrl.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:invoice_builder/shared/widgets/snackbar.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';

class BusinessComposScreen extends StatelessWidget {
  const BusinessComposScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(
        title: AppStrings.textTitleBusinessComposite,
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
            child: GetBuilder<BusinessController>(
              init: BusinessController(),
              builder: (controller) => Container(
                margin: EdgeInsets.symmetric(
                  vertical: AutoDimensions.calcH(5),
                  horizontal: AutoDimensions.calcW(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          AppTextFormField(
                            controller: controller.businessNameInputController,
                            label: AppStrings.textBssTitleNameComposite,
                            isRequired: true,
                            hint: AppStrings.textBssTitleNameHintComposite,
                          ),
                          AppTextFormField(
                            controller: controller.businessEmailInputController,
                            label: AppStrings.textBssTitleEmailComposite,
                            hint: AppStrings.textBssTitleEmailHintComposite,
                            isRequired: true,
                            type: TextInputType.emailAddress,
                          ),
                          AppTextFormField(
                            controller: controller.businessPhoneInputController,
                            label: AppStrings.textBssTitlePhoneNumberComposite,
                            hint: AppStrings.textBssTitlePhoneNumberHintComposite,
                            isRequired: true,
                            type: TextInputType.phone,
                          ),
                          AppTextFormField(
                            controller: controller.businessAddressInputController,
                            label: AppStrings.textBssTitleAddressComposite,
                            hint: AppStrings.textBssTitleAddressHintComposite,
                            height: AutoDimensions.calcH(100),
                            isRequired: true,
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<InvoiceController>(
                      builder: (controller) => DottedBorder(
                        color: AppColors.cPrimary,
                        child: SizedBox(
                          height: 150,
                          width: 200,
                          child: (controller.logo != null)
                              ? InkWell(
                                  onTap: () async {
                                    XFile? file =
                                        await ImagePicker().pickImage(source: ImageSource.gallery);
                                    if (file != null) {
                                      Uint8List imageBytes = await file.readAsBytes();
                                      controller.setBusinessLogo(imageBytes);
                                    }
                                  },
                                  child: Image.memory(controller.logo!))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        XFile? file = await ImagePicker()
                                            .pickImage(source: ImageSource.gallery);
                                        if (file != null) {
                                          Uint8List imageBytes = await file.readAsBytes();
                                          controller.setBusinessLogo(imageBytes);
                                        }
                                      },
                                      splashRadius: 20,
                                      icon: Icon(
                                        CupertinoIcons.photo_fill,
                                        color: AppColors.cPrimary,
                                        size: 30,
                                      ),
                                    ),
                                    AppText(
                                      text: AppStrings.textBssTitlePicLogoComposite,
                                      color: AppColors.cPrimary,
                                      style: AppTextStyle.textStyle5(),
                                    )
                                  ],
                                ),
                        ),
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
                              context: context, message: AppStrings.businessErrorScreenText);
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
          ),
        ),
      ),
    );
  }
}
