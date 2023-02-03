// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/models/item.dart';

class ItemsController extends GetxController {
  final RxList<Item> _itemsList = Get.find<InvoiceController>().itemsList;
  final RxDouble _total = 0.00.obs;
  TextEditingController itemNameInputController = TextEditingController();
  TextEditingController itemPriceInputController = TextEditingController();
  TextEditingController itemQtyInputController = TextEditingController();

  get itemsList => _itemsList;
  get total => _total;
  // validate form;

  bool validate() {
    if (itemNameInputController.text.isEmpty ||
        itemPriceInputController.text.isEmpty ||
        itemQtyInputController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please Fill all the required fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } else if (!itemPriceInputController.text.isNum || !itemQtyInputController.text.isNum) {
      Get.snackbar(
        "Error",
        "Item Price/Qty can only be a number",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } else {
      addItem(
        item_name: itemNameInputController.text,
        item_price: double.parse(itemPriceInputController.text),
        item_qty: int.parse(itemQtyInputController.text),
      );
      log(itemNameInputController.text);
      itemNameInputController.clear();
      itemPriceInputController.clear();
      itemQtyInputController.clear();
      update();
      return true;
    }
  }

  void addItem({required String item_name, required double item_price, required int item_qty}) {
    _itemsList.add(
      Item(
        name: item_name,
        price: item_price,
        qty: item_qty,
      ),
    );
    update();
    calcTotal();
  }

  void removeItem({required Item item}) {
    _itemsList.remove(item);
    update();
    calcTotal();
  }

  void editItemName({required Item item, required String name}) {
    String itemName = item.name = name;
    String newName = itemName;
    _itemsList.map((element) => Item(name: newName, qty: element.qty, price: element.price));
    update();
    calcTotal();
  }

  void editItemPrice({required Item item, required String price}) {
    double itemPrice = item.price = double.parse(price);
    double newPrice = itemPrice;
    _itemsList.map((element) => Item(name: element.name, qty: element.qty, price: newPrice));
    update();
    calcTotal();
  }

  void editItemQuantity({required Item item, required String qty}) {
    int itemQty = item.qty = int.parse(qty);
    int newQty = itemQty;
    _itemsList.map((element) => Item(name: element.name, qty: newQty, price: element.price));
    update();
    calcTotal();
  }

  void clearItems() {
    _itemsList.clear();
    update();
    calcTotal();
  }

  void calcTotal() => _total.value =
      _itemsList.fold(0, (previousValue, next) => previousValue + (next.price * next.qty));
}
