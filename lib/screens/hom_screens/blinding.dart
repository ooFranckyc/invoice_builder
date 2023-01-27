import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoices_ctrl.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllInvoiceController(), permanent: true);
  }
}
