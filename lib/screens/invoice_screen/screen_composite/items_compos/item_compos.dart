import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:invoice_builder/controllers/items_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/screens/invoice_screen/screen_composite/items_compos/widgets/table_represent_data.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:invoice_builder/shared/widgets/rich_text.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';

class ItemCompoScreen extends GetView<ItemsController> {
  @override
  final controller = Get.find<ItemsController>();
  ItemCompoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(title: 'Wrtie items', actions: [], showBackButton: true),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (scroll) {
            scroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: AutoDimensions.calcH(5),
                horizontal: AutoDimensions.calcW(15),
              ),
              child: Obx(() {
                return Column(
                  children: [
                    if (controller.itemsList.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Table(
                          border: TableBorder.all(color: AppColors.cPrimary.withOpacity(.10)),
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: AppColors.cGreyConcentric),
                              children: <Widget>[
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const AppText(text: 'Name'),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const AppText(text: 'Item Price'),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const AppText(text: 'Quantity'),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const AppText(text: 'Actions'),
                                  ),
                                ),
                              ],
                            ),
                            ...controller.itemsList
                                .map((itemx) => TableDataRepresentation(
                                      item: itemx,
                                    ))
                                .toList(),
                          ],
                        ),
                      )
                    else
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 3),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "You did not add any item yet!",
                                style: TextStyle(
                                    color: AppColors.cPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 65.0),
                                child: Text(
                                  "Please press + button for add new item.",
                                  style: TextStyle(
                                      color: AppColors.cPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (controller.itemsList.isNotEmpty)
                      SizedBox(
                        height: AutoDimensions.calcH(25),
                      ),
                    if (controller.itemsList.isNotEmpty) const Divider(),
                    if (controller.itemsList.isNotEmpty)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: AppRichText(
                          text: "Total: \$",
                          children: [
                            TextSpan(text: "${controller.total.value.toStringAsFixed(2)}")
                          ],
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.defaultDialog(
            radius: 12,
            title: 'New Items',
            titlePadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            contentPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Divider(),
                    AppTextFormField(
                      label: "Item name",
                      controller: controller.itemNameInputController,
                    ),
                    AppTextFormField(
                        label: 'Item Price',
                        controller: controller.itemPriceInputController,
                        type: TextInputType.number),
                    AppTextFormField(
                      label: 'Quantity',
                      controller: controller.itemQtyInputController,
                      type: TextInputType.number,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(AppColors.cPrimary),
                            padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(horizontal: 30))),
                        onPressed: () {
                          bool isValid = controller.validate();
                          if (isValid == true) {
                            Get.close(1);
                          }
                        },
                        child: Icon(Icons.done_all, color: AppColors.cWhite))
                  ],
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColors.cPrimary,
        child: Icon(
          CupertinoIcons.square_list,
          color: AppColors.cWhite,
        ),
      ),
    );
  }
}
