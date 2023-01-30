import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/controllers/invoices_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/models/invoice.dart';
import 'package:invoice_builder/screens/invoice_screen/screen_composite/payement_compos/payement_compos.dart';
import 'package:invoice_builder/screens/invoice_screen/widgets/options_view.dart';
import 'package:invoice_builder/screens/preview_screen/pdf_gen_ai.dart';
import 'package:invoice_builder/services/invoice_doc_handler.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(
          title: 'Create Invoice',
          actions: [
            Bounce(
              duration: const Duration(milliseconds: 180),
              onPressed: () {},
              child: Tooltip(
                message: 'Read minimal instructions.',
                decoration: BoxDecoration(
                    color: AppColors.cPrimary, borderRadius: BorderRadius.circular(5)),
                showDuration: const Duration(seconds: 3),
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.cGreyLow, shape: BoxShape.circle),
                  child: Icon(Icons.info_outline, color: AppColors.cPrimary),
                ),
              ),
            ),
            Bounce(
              duration: const Duration(milliseconds: 180),
              onPressed: () {},
              child: Tooltip(
                message: 'Use template for cute result',
                decoration: BoxDecoration(
                    color: AppColors.cPrimary, borderRadius: BorderRadius.circular(5)),
                showDuration: const Duration(seconds: 3),
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.cGreyLow, shape: BoxShape.circle),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Image.asset(
                          'assets/images/validate-invoice.png',
                          width: 120,
                          height: 120.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    OptionView(
                      onTap: () {},
                      title: 'Invoice${controller.id}',
                      subTitle: 'Create At ${InvoiceDocumentHandler.formatDate(
                        DateTime.now(),
                      )}',
                      showArrow: false,
                    ),
                    const SizedBox(height: 10.0),
                    OptionView(
                        title: 'New Buisiness',
                        subTitle: 'add your business details',
                        onTap: () {
                          Get.toNamed("/add_business");
                        },
                        isComplete: (controller.business != null) ? true : false,
                        showArrow: (controller.business != null) ? false : true),
                    OptionView(
                        title: 'Invoice to',
                        subTitle: 'add payer',
                        onTap: () {
                          Get.toNamed("/add_client");
                        },
                        isComplete: (controller.client != null) ? true : false,
                        showArrow: (controller.client != null) ? false : true),
                    OptionView(
                      title: 'Items',
                      subTitle: (controller.itemsList.isEmpty)
                          ? 'add items to your invoice'
                          : "${controller.itemsList.length} have been added",
                      onTap: () {
                        Get.toNamed("/add_items");
                      },
                      // isComplete:
                      //     (controller.itemsList.isNotEmpty) ? true : false,
                      // showArrow:
                      //     (controller.itemsList.isEmpty) ? true : false
                    ),
                    OptionView(
                        title: 'Payment',
                        subTitle: "add payment instructions",
                        onTap: () {
                          if (controller.paymentInstructions == null) {
                            Get.defaultDialog(
                              title: 'Payment Instructions',
                              content: PaymentInstructionsScreen(),
                            );
                          }
                        },
                        isComplete: (controller.paymentInstructions != null) ? true : false,
                        showArrow: (controller.paymentInstructions != null) ? false : true),
                    OptionView(
                        title: 'Signature',
                        subTitle: 'Sign your invoice',
                        onTap: () {
                          Get.toNamed("/sign_invoice");
                        },
                        isComplete: (controller.signature != null) ? true : false,
                        showArrow: (controller.signature != null) ? false : true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppBtn(
                          label: 'Preview',
                          action: () async {
                            if (controller.business != null &&
                                controller.client != null &&
                                //controller.signature != null &&
                                controller.paymentInstructions != null &&
                                controller.itemsList.isNotEmpty) {
                              Invoice invoice = await controller.generatePreviewInvoice();
                              Get.toNamed("/build_preview", arguments: {'invoice': invoice});
                            } else {
                              Get.snackbar("Error", "Please enter all the required fields!",
                                  backgroundColor: AppColors.cPrimary.withOpacity(.85),
                                  colorText: AppColors.cWhite,
                                  animationDuration: const Duration(milliseconds: 400),
                                  isDismissible: true,
                                  snackPosition: SnackPosition.TOP);
                            }
                          },
                        ),
                        SizedBox(
                          width: AutoDimensions.calcW(20),
                        ),
                        AppBtn(
                          label: 'Save',
                          color: AppColors.cPrimary,
                          textColor: Colors.white,
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
                              );
                              log('New Invoice Created');
                              Get.back();
                            } else {
                              Get.snackbar("Build Error",
                                  "Please you should filled all box for build with successfully your invoice",
                                  backgroundColor: AppColors.cPrimary.withOpacity(.85),
                                  colorText: AppColors.cWhite,
                                  animationDuration: const Duration(milliseconds: 400),
                                  isDismissible: true,
                                  snackPosition: SnackPosition.TOP);
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
