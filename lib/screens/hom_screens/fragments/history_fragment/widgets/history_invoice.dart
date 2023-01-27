import 'package:flutter/material.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/models/invoice.dart';
import 'package:invoice_builder/screens/preview_screen/pdf_gen_ai.dart';
import 'package:invoice_builder/services/invoice_doc_handler.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

// ignore: must_be_immutable
class HistoryInvoiceView extends StatelessWidget {
  Invoice invoice;
  HistoryInvoiceView({
    required this.invoice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => InvoiceDocumentHandler.saveInvoice(
        name: "invoice-${invoice.id}.pdf",
        fileBytes: await PdfInvoiceGenApi.generate(invoice),
      ),
      child: Tooltip(
        message: "Invoice ID #${invoice.id}.pdf, is ready",
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration:
            BoxDecoration(color: Colors.blue.shade700, borderRadius: BorderRadius.circular(5)),
        showDuration: const Duration(seconds: 2),
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: AutoDimensions.calcH(10), horizontal: AutoDimensions.calcW(8)),
          padding: EdgeInsets.symmetric(
              vertical: AutoDimensions.calcH(2), horizontal: AutoDimensions.calcW(12)),
          height: AutoDimensions.calcH(100),
          decoration: BoxDecoration(
              color: AppColors.cWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: AppColors.cPrimary)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              text: "Invoice ID #${invoice.id}",
                              align: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              text: invoice.to.name,
                              align: TextAlign.left,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              text: invoice.date,
                              align: TextAlign.left,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.download,
                      size: AutoDimensions.calcH(30),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
