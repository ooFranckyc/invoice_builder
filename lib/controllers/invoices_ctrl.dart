import 'package:get/get.dart';
import 'package:invoice_builder/models/invoice.dart';

class AllInvoiceController extends GetxController {
  final RxList _invoicesList = [].obs;

  get invoicesList => _invoicesList;
  void createNewInvoice(Invoice invoice) => _invoicesList.add(invoice);
  void downloadInvoice() {}
  void deleteInvoice() {}
  void shareInvoice() {}
  void uploadToCloud() {}
}
