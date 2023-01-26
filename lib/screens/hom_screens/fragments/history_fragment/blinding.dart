import 'package:get/get.dart';
import 'package:invoice_builder/controllers/invoices_ctrl.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllInvoiceController(), permanent: true);
  }
}
