// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:open_file/open_file.dart';

class InvoiceDocumentHandler {
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static void saveInvoice(
      {required String name,
      required Uint8List fileBytes,
      String path = "/storage/emulated/0/Documents"}) async {
    try {
      bool checkPermission = await Permission.storage.request().isGranted;
      if (checkPermission) {
        File pdf_doc = File("$path/$name");
        await pdf_doc.writeAsBytes(fileBytes);
        Get.snackbar("done", "Invoice Saved succesfully to $path/$name",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Storage permission denied !, please try again!",
            snackPosition: SnackPosition.BOTTOM);
        await Future.delayed(
          const Duration(seconds: 2),
        );
        await Permission.storage.request();
      }
    } on FileSystemException catch (e) {
      Get.snackbar("ERROR", "${e.message} $path/$name", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("ERROR", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  String path = "/storage/emulated/0/Documents";
  static void getAllInvoiceInRootTargetFolder() {}

  // static Future openInvoicePdfFile({required File file}) async {
  //   final url = file.path;
  //   await OpenFile.open(url);
  // }
}
