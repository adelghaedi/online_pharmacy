import 'package:get/get.dart';

import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../controllers/profile_base_controller.dart';

class ProfileAdminController extends ProfileBaseController {
  @override
  bool isProfileUser=false;

  @override
  void onPressedEditInfo() async{
    final result = await Get.toNamed(
      PharmacyModuleRoutes.editAdminPage,
      arguments: userInfo.toJson(),
    );
    if (result != null) {
      Get.back(
        result: result,
      );
    }
  }
}
