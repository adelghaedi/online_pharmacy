import 'package:get/get.dart';

import '../controllers/drugs_user_controller.dart';

class DrugsUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      DrugsUserController.new,
    );
  }
}
