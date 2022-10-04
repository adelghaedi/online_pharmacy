import 'package:get/get.dart';

import '../controllers/edit_user_controller.dart';

class EditAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => EditUserController(
        isAdmin: true,
      ),
    );
  }
}
