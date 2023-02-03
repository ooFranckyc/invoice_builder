import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoices_ctrl.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/history_fragment/widgets/history_invoice.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class HistoryFragment extends GetView<AllInvoiceController> {
  const HistoryFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.invoicesList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text: AppStrings.nothinInvoiceBuildTitleHistoryFragment,
                color: AppColors.cPrimary,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: AppText(
                  text: AppStrings.nothinTempInvoiceBuildDescriptionHistoryFragment,
                  color: AppColors.cPrimary.withOpacity(.70),
                  maxline: 2,
                  style: AppTextStyle.textStyle5(),
                ),
              )
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ...controller.invoicesList
                  .map((invoice) => HistoryInvoiceView(invoice: invoice))
                  .toList()
            ],
          ),
        );
      }
    });
  }
}
