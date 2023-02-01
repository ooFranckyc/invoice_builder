import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/models/invoice.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
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
    return Tooltip(
      message:
          "Invoice ID #${invoice.id}.pdf, has saved, ready\nFile location: Local phone document\nInvoice Destination: ${invoice.to.name}",
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(color: Colors.blue.shade700, borderRadius: BorderRadius.circular(5)),
      showDuration: const Duration(seconds: 5),
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
                            text: "Invoice ID #${invoice.id.substring(10)}",
                            style: AppTextStyle.textStyle3(),
                            align: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            text: 'Customer: ${invoice.to.name}',
                            align: TextAlign.left,
                            style: AppTextStyle.textStyle5(),
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
                            text: 'Date build: ${invoice.date}',
                            align: TextAlign.left,
                            style: AppTextStyle.textStyle7(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Bounce(
                      duration: const Duration(milliseconds: 180),
                      onPressed: () {},
                      child: Icon(
                        Icons.remove_red_eye,
                        size: AutoDimensions.calcH(25),
                      ),
                    )),
                const SizedBox(width: 10),
                Align(
                    alignment: Alignment.centerRight,
                    child: Bounce(
                      duration: const Duration(milliseconds: 180),
                      onPressed: () {},
                      child: Icon(
                        Icons.share,
                        size: AutoDimensions.calcH(25),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
