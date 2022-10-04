import 'package:get/get.dart';
import '../controllers/add_user_controller.dart';

class AddAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddUserController(isAdmin: true));
  }
}
