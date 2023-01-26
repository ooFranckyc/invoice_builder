import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';
import 'package:invoice_builder/models/client.dart';
import 'package:invoice_builder/shared/colors.dart';

class ClientController extends GetxController {
  Client? client;
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
      Get.snackbar("Error", "Please Fill all the required fields",
          backgroundColor: AppColors.cPrimary.withOpacity(.85),
          colorText: AppColors.cWhite,
          animationDuration: const Duration(milliseconds: 400),
          isDismissible: true,
          snackPosition: SnackPosition.TOP);
      return false;
    } else {
      client = Client(
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
