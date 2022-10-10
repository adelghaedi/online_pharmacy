import 'package:get/get.dart';

import '../controllers/pharmacy_drug_management_controller.dart';

class PharmacyDrugManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      PharmacyDrugsManagementController.new,
    );
  }
}
