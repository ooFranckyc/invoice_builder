import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoice_ctrl.dart';

class InvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => InvoiceController(),
    );
  }
}
