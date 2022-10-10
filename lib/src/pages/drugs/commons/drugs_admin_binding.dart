import 'package:get/get.dart';

import '../controllers/drugs_admin_controller.dart';

class DrugsAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      DrugsAdminController.new,
    );
  }
}
