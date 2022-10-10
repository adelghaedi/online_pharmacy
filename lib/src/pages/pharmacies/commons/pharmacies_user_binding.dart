import 'package:get/get.dart';

import '../controllers/pharmacies_user_controller.dart';

class PharmaciesUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PharmaciesUserController.new);
  }
}
