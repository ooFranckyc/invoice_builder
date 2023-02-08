import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/controllers/invoices_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/models/invoice.dart';
import 'package:invoice_builder/screens/invoice_screens/widgets/options_view.dart';
import 'package:invoice_builder/screens/preview_screens/pdf_gen_ai.dart';
import 'package:invoice_builder/services/invoice_doc_handler.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:invoice_builder/shared/widgets/snackbar.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(
          title: AppStrings.textTitleInvoiceScreen,
          actions: [
            Bounce(
              duration: const Duration(milliseconds: 180),
              onPressed: () {},
              child: Tooltip(
                message: AppStrings.tooltipReadBtnInvoiceScreen,
                decoration: BoxDecoration(
                    color: AppColors.cPrimary, borderRadius: BorderRadius.circular(5)),
                showDuration: const Duration(seconds: 3),
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //     color: AppColors.cPrimary.withOpacity(.10), shape: BoxShape.circle),
                  child: Icon(Icons.info_outline, color: AppColors.cPrimary),
                ),
              ),
            ),
            Bounce(
              duration: const Duration(milliseconds: 180),
              onPressed: () {
                Get.toNamed(AppLinks.tempScreen);
              },
              child: Tooltip(
                message: AppStrings.tooltipTemplateBtnInvoiceScreen,
                decoration: BoxDecoration(
                    color: AppColors.cPrimary, borderRadius: BorderRadius.circular(5)),
                showDuration: const Duration(seconds: 3),
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //     color: AppColors.cPrimary.withOpacity(.10), shape: BoxShape.circle),
                  child: Icon(CupertinoIcons.doc_text_search, color: AppColors.cPrimary),
                ),
              ),
            )
          ],
          showBackButton: true),
      backgroundColor: AppColors.cWhite,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (scroll) {
          scroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<InvoiceController>(
            init: InvoiceController(),
            builder: (controller) {
              if (controller.id == '0') {
                String id = DateTime.now().microsecondsSinceEpoch.toString();
                controller.id = id;
              } else {
                // controller id is good.
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: SvgPicture.asset(AppStrings.prepareBuildInvoiceLogo,
                            width: 200,
                            height: 200,
                            semanticsLabel: AppStrings.prepareBuildInvoiceLogoSemantic)),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: '${AppStrings.textInvoice} ${controller.id.substring(0, 5)}',
                            style: AppTextStyle.textStyle2(color: AppColors.cPrimary),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: AppStrings.textInvoiceDate,
                                style: AppTextStyle.textStyle3(color: AppColors.cPrimary),
                              ),
                              AppText(
                                text: InvoiceDocumentHandler.formatDate(DateTime.now()),
                                style: AppTextStyle.textStyle4(
                                    color: AppColors.cPrimary.withOpacity(.60)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    OptionView(
                        title: AppStrings.textInvoiceCustomer,
                        onTap: () {
                          Get.toNamed(AppLinks.newCustomerScreen);
                        },
                        isComplete: (controller.client != null) ? true : false,
                        showArrow: (controller.client != null) ? false : true),
                    OptionView(
                      title: AppStrings.textInvoiceManageProduct,
                      // subTitle: (controller.itemsList.isEmpty)
                      //     ? 'add items to your invoice'
                      //     : "${controller.itemsList.length} have been added",
                      onTap: () {
                        Get.toNamed(AppLinks.newItemScreen);
                      },
                      // isComplete:
                      //     (controller.itemsList.isNotEmpty) ? true : false,
                      // showArrow:
                      //     (controller.itemsList.isEmpty) ? true : false
                    ),
                    OptionView(
                        title: AppStrings.textInvoiceBusiness,
                        onTap: () {
                          Get.toNamed(AppLinks.newBuisinessScreen);
                        },
                        isComplete: (controller.business != null) ? true : false,
                        showArrow: (controller.business != null) ? false : true),
                    OptionView(
                        title: AppStrings.textInvoicePayment,
                        onTap: () {
                          Get.toNamed(AppLinks.newPaymentScreen);
                          // if (controller.paymentInstructions == null) {
                          //   Get.defaultDialog(
                          //     title: AppStrings.textInvoicePaymentInstruction,
                          //     content: PaymentInstructionsScreen(),
                          //   );
                          // }
                        },
                        isComplete: (controller.paymentInstructions != null) ? true : false,
                        showArrow: (controller.paymentInstructions != null) ? false : true),
                    OptionView(
                        title: AppStrings.textInvoiceSignature,
                        onTap: () {
                          Get.toNamed(AppLinks.signatureScreen);
                        },
                        isComplete: (controller.signature != null) ? true : false,
                        showArrow: (controller.signature != null) ? false : true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppBtn(
                          label: AppStrings.textInvoicePreview,
                          action: () async {
                            if (controller.business != null &&
                                controller.client != null &&
                                //controller.signature != null &&
                                controller.paymentInstructions != null &&
                                controller.itemsList.isNotEmpty) {
                              Invoice invoice = await controller.generatePreviewInvoice();
                              Get.toNamed(AppStrings.previewScreenTag,
                                  arguments: {'invoice': invoice});
                            } else {
                              messageWithSnackbar(
                                  context: context,
                                  message: AppStrings.invoicePreviewErrorScreenText);
                            }
                          },
                        ),
                        SizedBox(
                          width: AutoDimensions.calcW(20),
                        ),
                        AppBtn(
                          label: AppStrings.textCreateBtn,
                          color: AppColors.cPrimary,
                          textColor: AppColors.cWhite,
                          action: () async {
                            if (controller.business != null &&
                                controller.client != null &&
                                controller.signature != null &&
                                controller.paymentInstructions != null) {
                              Invoice invoice = await controller.generatePreviewInvoice();
                              Get.find<AllInvoiceController>().createNewInvoice(invoice);
                              InvoiceDocumentHandler.saveInvoice(
                                name: "invoice-${invoice.id}.pdf",
                                fileBytes: await PdfInvoiceGenApi.generate(invoice),
                              ); // Invoice Created and Saved to device.
                              Get.back();
                            } else {
                              messageWithSnackbar(
                                  context: context, message: AppStrings.invoiceSaveErrorScreenText);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
