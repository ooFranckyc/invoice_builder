import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/models/invoice.dart';
import 'package:invoice_builder/screens/preview_screens/pdf_gen_ai.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  Map<String, dynamic> args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(
          title: AppStrings.textTitlePreviewInvoiceScreen, actions: [], showBackButton: true),
      body: FutureBuilder(
        future: PdfInvoiceGenApi.generate(args['invoice'] as Invoice),
        builder: (context, snapshot) {
          dynamic documentBytes = snapshot.data;
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: AutoDimensions.calcW(15), vertical: AutoDimensions.calcH(8)),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: SfPdfViewer.memory(documentBytes, initialZoomLevel: .5),
                )),
                SizedBox(
                  height: Get.size.height * 0.2,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back(closeOverlays: true);
                        },
                        splashColor: AppColors.cGreyLow,
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            margin: const EdgeInsets.only(top: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.cPrimary),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              AppStrings.textClosePreviewBtn.toUpperCase(),
                              style: TextStyle(
                                color: AppColors.cPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.cPrimary,
                  ),
                  Text(
                    AppStrings.textGenPreviewInvoiceScreen,
                    style: TextStyle(
                        color: AppColors.cPrimary, fontWeight: FontWeight.w700, fontSize: 16),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
