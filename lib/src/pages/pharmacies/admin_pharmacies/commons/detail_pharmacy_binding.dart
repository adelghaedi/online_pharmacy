import 'package:get/get.dart';
import '../controllers/detail_pharmacy_controller.dart';

class DetailPharmacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      DetailPharmacyController.new,
    );
  }
}
