import 'package:get/get.dart';
import 'package:pharmacy/src/pages/forgot_password/controllers/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ForgotPasswordController.new);
  }
}
