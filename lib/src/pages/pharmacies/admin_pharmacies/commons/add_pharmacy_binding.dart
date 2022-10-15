import 'package:get/get.dart';
import '../controllers/add_pharmacy_controller.dart';

class AddPharmacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      AddPharmacyController.new,
    );
  }
}
