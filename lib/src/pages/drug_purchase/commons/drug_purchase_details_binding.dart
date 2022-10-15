import 'package:get/get.dart';

import '../controllers/drug_purchase_details_controller.dart';

class DrugPurchaseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      DrugPurchaseDetailsController.new,
    );
  }
}
