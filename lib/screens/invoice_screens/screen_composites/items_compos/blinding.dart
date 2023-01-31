import 'package:get/get.dart';
import 'package:invoice_builder/controllers/items_ctrl.dart';

class ItemsBidning extends Bindings {
  @override
  void dependencies() {
    Get.put(ItemsController(), permanent: true);
  }
}
