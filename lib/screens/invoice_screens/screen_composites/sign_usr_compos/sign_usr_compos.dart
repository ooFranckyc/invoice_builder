import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/widgets/button.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

class SignatureScreen extends GetView<InvoiceController> {
  const SignatureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(
          title: AppStrings.textTitleSignatureComposite, actions: [], showBackButton: true),
      backgroundColor: AppColors.cWhite,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (scroll) {
              scroll.disallowIndicator();
              return true;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Get.size.height * 0.45,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: DottedBorder(
                    color: AppColors.cPrimary.withOpacity(.10),
                    radius: const Radius.circular(12),
                    strokeWidth: 2,
                    child: SfSignaturePad(
                      key: _signaturePadKey,
                      minimumStrokeWidth: 2,
                      maximumStrokeWidth: 4,
                      strokeColor: AppColors.cPrimary,
                      backgroundColor: AppColors.cGreyLow,
                    ),
                  ),
                ),
                SizedBox(
                  height: AutoDimensions.calcH(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppBtn(
                      label: AppStrings.textSaveBtn,
                      action: () async {
                        ui.Image image = await _signaturePadKey.currentState!.toImage();
                        final pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
                        controller.setSignature(pngBytes!);
                        Get.back();
                      },
                      color: AppColors.cPrimary,
                      textColor: AppColors.cWhite,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AppBtn(
                      label: AppStrings.textRetryBtn,
                      action: () async {
                        _signaturePadKey.currentState!.clear();
                      },
                      color: AppColors.cRed,
                      textColor: AppColors.cWhite,
                    ),
                  ],
                )
              ],
            )
            // child: Column(
            //   children: [
            //     // (imgBytes != null)
            //     //     ? Image.memory(
            //     //         Uint8List.view(imgBytes!.buffer),
            //     //       )
            //     //     : const Text("")
            //   ],
            ),
      ),
    );
  }
}
