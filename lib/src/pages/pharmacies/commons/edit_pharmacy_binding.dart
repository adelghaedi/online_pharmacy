import 'package:get/get.dart';

import '../controllers/edit_pharmacy_controller.dart';

class EditPharmacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      EditPharmacyController.new,
    );
  }
}
