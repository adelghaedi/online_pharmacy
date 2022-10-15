import 'package:get/get.dart';

import '../controllers/pharmacies_admin_controller.dart';

class PharmaciesAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PharmaciesAdminController.new);
  }
}
