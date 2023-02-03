import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:invoice_builder/models/business.dart';
import 'package:invoice_builder/models/customer.dart';
import 'package:invoice_builder/models/invoice.dart';
import 'package:invoice_builder/models/item.dart';
import 'package:invoice_builder/services/invoice_doc_handler.dart';

class InvoiceController extends GetxController {
  String id = "0";
  Business? business;
  Customer? client;
  RxList<Item> itemsList = <Item>[].obs;
  String? paymentInstructions;
  Uint8List? logo;
  ByteData? signature;

  void setBusiness(Business val) async {
    business = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setCustomer(Customer val) async {
    client = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setItems(List<Item> val) async {
    itemsList.addAll(val);
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setPaymentInstructions(String val) async {
    paymentInstructions = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setSignature(ByteData val) async {
    signature = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setBusinessLogo(Uint8List? val) async {
    logo = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  Future<Invoice> generatePreviewInvoice() async => Invoice(
      id: id,
      date: InvoiceDocumentHandler.formatDate(DateTime.now()),
      from: business!,
      to: client!,
      items: itemsList,
      paymentInstructions: paymentInstructions!,
      total: itemsList.fold(0, (previousValue, next) => previousValue + (next.price * next.qty)),
      signature: signature!);
  @override
  void onClose() {
    id = "0";
    business = null;
    client = null;
    paymentInstructions = null;
    itemsList.value = [];
    signature = null;
    super.onClose();
  }
}
