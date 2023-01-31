// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/items_ctrl.dart';
import 'package:invoice_builder/models/item.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

TableRow TableDataRepresentation({required Item? item}) {
  ItemsController controller = Get.find();
  return TableRow(
    children: <Widget>[
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: AppText(
            text: (item != null) ? item.name : "null",
            style: AppTextStyle.textStyle4(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: AppText(
            text: (item != null) ? "\$${item.price.toStringAsFixed(2)}" : "-",
            style: AppTextStyle.textStyle4(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: AppText(
            text: (item != null) ? "${item.qty}" : "-",
            style: AppTextStyle.textStyle4(),
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.cPrimary,
                ),
                alignment: Alignment.center,
                height: 30,
                width: 30,
                child: IconButton(
                  splashRadius: 18,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_sharp,
                    color: AppColors.cWhite,
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
                    (item != null) ? controller.removeItem(item: item) : print("null");
                  },
                  icon: const Icon(
                    Icons.delete_sharp,
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
