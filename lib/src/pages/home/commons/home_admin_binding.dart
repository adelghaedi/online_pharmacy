import 'package:get/get.dart';
import 'package:pharmacy/src/pages/home/controllers/home_admin_controller.dart';

class HomeAdminBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(HomeAdminController.new);
  }

}