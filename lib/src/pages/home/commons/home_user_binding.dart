import 'package:get/get.dart';
import '../controllers/home_user_controller.dart';

class HomeUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeUserController.new);
  }
}
