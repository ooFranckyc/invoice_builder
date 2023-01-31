import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/models/business.dart';

class BusinessController extends GetxController {
  Business? business;
  TextEditingController businessNameInputController = TextEditingController();
  TextEditingController businessEmailInputController = TextEditingController();
  TextEditingController businessPhoneInputController = TextEditingController();
  TextEditingController businessAddressInputController = TextEditingController();

  // validate input
  bool validate() {
    if (businessNameInputController.text.isEmpty ||
        businessEmailInputController.text.isEmpty ||
        businessPhoneInputController.text.isEmpty ||
        businessAddressInputController.text.isEmpty) {
      return false;
    } else {
      business = Business(
          name: businessNameInputController.text,
          address: businessAddressInputController.text,
          phone: businessPhoneInputController.text,
          email: businessEmailInputController.text,
          logo: Get.find<InvoiceController>().logo);
      return true;
    }
  }

  @override
  void onClose() {
    if (business != null) {
      businessNameInputController.clear();
      businessEmailInputController.clear();
      businessPhoneInputController.clear();
      businessAddressInputController.clear();
      Get.find<InvoiceController>().setBusiness(business!);
    }
    super.onClose();
  }

  @override
  void dispose() {
    if (business != null) {
      businessNameInputController.dispose();
      businessEmailInputController.dispose();
      businessPhoneInputController.dispose();
      businessAddressInputController.dispose();
    }
    super.dispose();
  }
  // logo controller
  // upload logo
}
