import 'package:get/get.dart';

import '../controllers/drug_purchase_controller.dart';

class DrugPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      DrugPurchaseController.new,
    );
  }
}
