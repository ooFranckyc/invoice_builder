import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/shared/colors.dart';
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
      backgroundColor: AppColors.cWhite,
      appBar: invoiceBuildAppBar(title: 'Sign your invoice', actions: [], showBackButton: true),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (scroll) {
              scroll.disallowIndicator();
              return true;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DottedBorder(
                  color: AppColors.cPrimary,
                  strokeWidth: .5,
                  child: Container(
                    height: Get.size.height * 0.45,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: DottedBorder(
                      color: AppColors.cPrimary.withOpacity(.50),
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
                ),
                SizedBox(
                  height: AutoDimensions.calcH(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppBtn(
                      label: 'Save',
                      action: () async {
                        ui.Image image = await _signaturePadKey.currentState!.toImage();
                        final pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
                        controller.setSignature(pngBytes!);
                        Get.back();
                      },
                      color: AppColors.cPrimary,
                      textColor: Colors.white,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AppBtn(
                      label: 'Retry',
                      action: () async {
                        _signaturePadKey.currentState!.clear();
                      },
                      color: AppColors.cRed,
                      textColor: Colors.white,
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
