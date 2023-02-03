import 'package:flutter/services.dart';
import 'package:invoice_builder/models/business.dart';
import 'package:invoice_builder/models/customer.dart';
import 'package:invoice_builder/models/item.dart';

class Invoice {
  String id;
  String date;
  Business from;
  Customer to;
  List<Item> items;
  String paymentInstructions;
  double total;
  ByteData signature;
  Invoice(
      {required this.id,
      required this.date,
      required this.from,
      required this.to,
      required this.items,
      required this.paymentInstructions,
      required this.total,
      required this.signature});
}
