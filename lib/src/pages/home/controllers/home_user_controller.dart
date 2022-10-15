import 'package:get/get.dart';

import '../../../components/custom_scaffold/controllers/custom_scaffold_controller.dart';
import '../../shared/models/user_profile_model.dart';
import '../../shared/models/user_view_model.dart';
import '../controllers/home_base_controller.dart';
import '../../../infrastructure/routes/pharmacy_module_routes.dart';

class HomeUserController extends HomeBaseController {
  @override
  bool isHomeUser = true;

  @override
  void onTapDrugsItem() {
    Get.toNamed(
      PharmacyModuleRoutes.drugsUserPage,
    );
  }

  @override
  void onTapPharmaciesItem() {
    Get.toNamed(
      PharmacyModuleRoutes.pharmaciesUserPage,
    );
  }

  @override
  void onTapProfileItem() async {
    final result = await Get.toNamed(
      PharmacyModuleRoutes.profileUserPage,
    );
    if (result != null) {
      final UserViewModel user = result as UserViewModel;
      UserProfileModel userProfile = UserProfileModel(
        id: user.id,
        firstName: user.firstName,
        mobile: user.mobile,
        base64Image: user.base64Image,
        drugs: RxList(user.drugs),
      );
      CustomScaffoldController.userProfile.value = userProfile;
    }
  }
}
