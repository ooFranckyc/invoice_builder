// ignore_for_file: non_constant_identifier_names, avoid_print
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/items_ctrl.dart';
import 'package:invoice_builder/models/item.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/snackbar.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';

TableRow TableDataRepresentation({required Item? item, required BuildContext context}) {
  ItemsController controller = Get.find();
  return TableRow(
    children: <Widget>[
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: GestureDetector(
          onLongPress: () async {
            await Get.defaultDialog(
              radius: 8,
              title: AppStrings.editName,
              titleStyle: AppTextStyle.textStyle3(),
              titlePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Divider(),
                      AppTextFormField(
                        label: AppStrings.newName,
                        controller: controller.itemNameInputController,
                        isRequired: true,
                        type: TextInputType.multiline,
                        style: AppTextStyle.textStyle3(weight: FontWeight.w500),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(AppColors.cPrimary),
                              padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(horizontal: 30))),
                          onPressed: () {
                            if (controller.itemNameInputController.text.isNotEmpty) {
                              controller.editItemName(
                                  item: item!, name: controller.itemNameInputController.text);
                              log(controller.itemNameInputController.text); // just for debug
                              Get.close(1);
                              controller.itemNameInputController.clear();
                            } else {
                              messageWithSnackbar(
                                  context: context,
                                  message: AppStrings.tabRepresentDataErrorScreenTextI);
                            }
                          },
                          child: AppText(
                            text: AppStrings.renameText,
                            style: AppTextStyle.textStyle4(color: AppColors.cWhite),
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            child: AppText(
              text: (item != null) ? item.name : "null",
              style: AppTextStyle.textStyle4(),
            ),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: GestureDetector(
          onLongPress: () async {
            await Get.defaultDialog(
              radius: 8,
              title: AppStrings.editPrice,
              titleStyle: AppTextStyle.textStyle3(),
              titlePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Divider(),
                      AppTextFormField(
                        label: AppStrings.newPrice,
                        controller: controller.itemPriceInputController,
                        isRequired: true,
                        type: TextInputType.number,
                        style: AppTextStyle.textStyle3(weight: FontWeight.w500),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(AppColors.cPrimary),
                              padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(horizontal: 30))),
                          onPressed: () {
                            if (controller.itemPriceInputController.text.isNotEmpty) {
                              controller.editItemPrice(
                                  item: item!, price: controller.itemPriceInputController.text);
                              log(controller.itemPriceInputController.text); // just for debug
                              Get.close(1);
                              controller.itemPriceInputController.clear();
                            } else {
                              messageWithSnackbar(
                                  context: context,
                                  message: AppStrings.tabRepresentDataErrorScreenTextII);
                            }
                          },
                          child: AppText(
                            text: AppStrings.renameText,
                            style: AppTextStyle.textStyle4(color: AppColors.cWhite),
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: AppText(
              text: (item != null) ? "\$${item.price.toStringAsFixed(2)}" : "-",
              style: AppTextStyle.textStyle4(),
            ),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: GestureDetector(
          onLongPress: () async {
            await Get.defaultDialog(
              radius: 8,
              title: AppStrings.editQty,
              titleStyle: AppTextStyle.textStyle3(),
              titlePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Divider(),
                      AppTextFormField(
                        label: AppStrings.newQty,
                        controller: controller.itemQtyInputController,
                        isRequired: true,
                        type: TextInputType.number,
                        style: AppTextStyle.textStyle3(weight: FontWeight.w500),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(AppColors.cPrimary),
                              padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(horizontal: 30))),
                          onPressed: () {
                            if (controller.itemQtyInputController.text.isNotEmpty) {
                              controller.editItemQuantity(
                                  item: item!, qty: controller.itemQtyInputController.text);
                              log(controller.itemQtyInputController.text);
                              Get.close(1);
                              controller.itemQtyInputController.clear();
                            } else {
                              messageWithSnackbar(
                                  context: context,
                                  message: AppStrings.tabRepresentDataErrorScreenTextIII);
                            }
                          },
                          child: AppText(
                            text: AppStrings.renameText,
                            style: AppTextStyle.textStyle4(color: AppColors.cWhite),
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: AppText(
              text: (item != null) ? "${item.qty}" : "-",
              style: AppTextStyle.textStyle4(),
            ),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                child: IconButton(
                  splashRadius: 18,
                  padding: const EdgeInsets.all(0),
                  onPressed: () async {
                    await Get.defaultDialog(
                      radius: 8,
                      title: AppStrings.editInformationText,
                      titleStyle: AppTextStyle.textStyle3(),
                      titlePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      contentPadding: EdgeInsets.zero,
                      content: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Divider(),
                              AppTextFormField(
                                label: AppStrings.newName,
                                controller: controller.itemNameInputController,
                                isRequired: true,
                                style: AppTextStyle.textStyle3(weight: FontWeight.w500),
                              ),
                              AppTextFormField(
                                label: AppStrings.newPrice,
                                controller: controller.itemNameInputController,
                                isRequired: true,
                                style: AppTextStyle.textStyle3(weight: FontWeight.w500),
                              ),
                              AppTextFormField(
                                label: AppStrings.newQty,
                                controller: controller.itemNameInputController,
                                isRequired: true,
                                style: AppTextStyle.textStyle3(weight: FontWeight.w500),
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(AppColors.cPrimary),
                                      padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                          EdgeInsets.symmetric(horizontal: 30))),
                                  onPressed: () {},
                                  child: AppText(
                                    text: AppStrings.renameText,
                                    style: AppTextStyle.textStyle4(color: AppColors.cWhite),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit_sharp,
                    color: AppColors.cPrimary,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red.shade400,
                ),
                alignment: Alignment.center,
                height: 30,
                width: 30,
                child: IconButton(
                  splashRadius: 18,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    (item != null)
                        ? controller.removeItem(item: item)
                        : log("Failed to remove null item");
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
