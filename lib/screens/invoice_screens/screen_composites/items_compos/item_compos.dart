import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:invoice_builder/controllers/items_ctrl.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/screens/invoice_screens/screen_composites/items_compos/widgets/table_represent_data.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/invoice_b_appbar.dart';
import 'package:invoice_builder/shared/widgets/rich_text.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:invoice_builder/shared/widgets/text_field.dart';

/*
  file name: item_compos.dart
  Un ecouteur d'evenement est mis le plus haut possible pour notifier flutter,
  d'operer une construction(re) de widgets : NotificationListerner.
  items_compo.dart cree un ecran, qui affichera la progression d'ajout d'element 
  constituant la facture de l'utilisateur, ces infomations sont ensuite modeliser 
  et rendu graphiquement grace au widget approprier.
  ? Emplacement du fichier: $/widgets/table_represent_data.dart
  Pour bien comprendre le code suivant: vous devez comprendre getx...👌
*/

class ItemCompoScreen extends GetView<ItemsController> {
  @override
  final controller = Get.find<ItemsController>();
  ItemCompoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: invoiceBuildAppBar(
          title: AppStrings.textTitleItemsComposite, actions: [], showBackButton: true),
      backgroundColor: AppColors.cWhite,
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
                                  child: Tooltip(
                                    message: AppStrings.tooltipItemsCompositeCellname,
                                    showDuration: const Duration(seconds: 2),
                                    decoration: BoxDecoration(
                                        color: AppColors.cPrimary,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: AppText(
                                        text: AppStrings.textTitleCellnameItemsComposite,
                                        style: AppTextStyle.textStyle5(weight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Tooltip(
                                    message: AppStrings.textTitleCellPriceItemsComposite,
                                    showDuration: const Duration(seconds: 2),
                                    decoration: BoxDecoration(
                                        color: AppColors.cPrimary,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: AppText(
                                        text: AppStrings.textTitleCellPriceItemsComposite,
                                        style: AppTextStyle.textStyle5(weight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Tooltip(
                                    message: AppStrings.textTitleCellQuantityItemsComposite,
                                    showDuration: const Duration(seconds: 2),
                                    decoration: BoxDecoration(
                                        color: AppColors.cPrimary,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: AppText(
                                        text: AppStrings.textTitleCellQuantityItemsComposite,
                                        style: AppTextStyle.textStyle5(weight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Tooltip(
                                    message: AppStrings.textTitleCellEditDeleteItemsComposite,
                                    showDuration: const Duration(seconds: 2),
                                    decoration: BoxDecoration(
                                        color: AppColors.cPrimary,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: AppText(
                                        text: AppStrings.textTitleCellActionsItemsComposite,
                                        style: AppTextStyle.textStyle5(weight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...controller.itemsList
                                .map((itemx) =>
                                    TableDataRepresentation(item: itemx, context: context))
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
                                AppStrings.textTitleNoInvoiceBuildItemsComposite,
                                style: AppTextStyle.textStyle2(),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.textTitleNoInvoiceBuildConIItemsComposite,
                                    style: AppTextStyle.textStyle4(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    CupertinoIcons.square_list,
                                    color: AppColors.cPrimary,
                                  ),
                                  Text(
                                    AppStrings.textTitleNoInvoiceBuildConIIItemsComposite,
                                    maxLines: 2,
                                    style: AppTextStyle.textStyle4(),
                                  )
                                ],
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
                          text: "${AppStrings.totalText}\$",
                          style: AppTextStyle.textStyle4(weight: FontWeight.w500),
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
            title: AppStrings.newItemText,
            titlePadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            contentPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Divider(),
                    AppTextFormField(
                      label: AppStrings.tooltipItemsCompositeCellname,
                      controller: controller.itemNameInputController,
                      isRequired: true,
                      style: AppTextStyle.textStyle3(weight: FontWeight.w500),
                    ),
                    AppTextFormField(
                      label: AppStrings.textTitleCellPriceItemsComposite,
                      controller: controller.itemPriceInputController,
                      type: TextInputType.number,
                      isRequired: true,
                      style: AppTextStyle.textStyle3(weight: FontWeight.w500),
                    ),
                    AppTextFormField(
                      label: AppStrings.textTitleCellQuantityItemsComposite,
                      controller: controller.itemQtyInputController,
                      type: TextInputType.number,
                      isRequired: true,
                      style: AppTextStyle.textStyle3(weight: FontWeight.w500),
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
