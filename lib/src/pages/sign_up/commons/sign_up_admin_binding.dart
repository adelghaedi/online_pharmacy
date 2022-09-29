import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart';

class SignUpAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(isAdmin: true));
  }
}
