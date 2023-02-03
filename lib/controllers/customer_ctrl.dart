import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/models/customer.dart';

class CustomerController extends GetxController {
  Customer? client;
  TextEditingController customerNameInputController = TextEditingController();
  TextEditingController customerEmailInputController = TextEditingController();
  TextEditingController customerPhoneInputController = TextEditingController();
  TextEditingController customerAddressInputController = TextEditingController();

  // validate input
  bool validate() {
    if (customerNameInputController.text.isEmpty ||
        customerEmailInputController.text.isEmpty ||
        customerPhoneInputController.text.isEmpty ||
        customerAddressInputController.text.isEmpty) {
      return false;
    } else {
      client = Customer(
          address: customerAddressInputController.text,
          email: customerEmailInputController.text,
          name: customerNameInputController.text,
          phone: customerPhoneInputController.text);
      return true;
    }
  }

  @override
  void onClose() {
    if (client != null) {
      customerAddressInputController.clear();
      customerEmailInputController.clear();
      customerNameInputController.clear();
      customerPhoneInputController.clear();
      Get.find<InvoiceController>().setCustomer(client!);
    }
    super.onClose();
  }

  @override
  void dispose() {
    if (client != null) {
      customerAddressInputController.dispose();
      customerEmailInputController.dispose();
      customerNameInputController.dispose();
      customerPhoneInputController.dispose();
    }
    super.dispose();
  }
}
