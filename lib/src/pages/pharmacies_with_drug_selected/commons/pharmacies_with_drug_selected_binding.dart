import 'package:get/get.dart';

import '../controllers/pharmacies_with_drug_selected_controller.dart';

class PharmaciesWithDrugSelectedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      PharmaciesWithDrugSelectedController.new,
    );
  }
}
