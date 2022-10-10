import 'package:get/get.dart';


import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../controllers/profile_base_controller.dart';

class ProfileUserController extends ProfileBaseController {
  @override
  bool isProfileUser = true;

  @override
  void onPressedEditInfo() async{
    final result = await Get.toNamed(
      PharmacyModuleRoutes.editUserPage,
      arguments: userInfo.toJson(),
    );
    if (result != null) {
      Get.back(
        result: result,
      );
    }
  }
}
