import 'package:get/get.dart';

import '../controllers/pharmacies_controller.dart';

class PharmaciesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(PharmaciesController.new);
  }

}