import 'package:get/get.dart';

import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../controllers/home_base_controller.dart';
import '../../shared/models/user_view_model.dart';
import '../../shared/models/user_profile_model.dart';
import '../../../components/customScaffold/controllers/custom_scaffold_controller.dart';

class HomeAdminController extends HomeBaseController {
  @override
  bool isHomeUser = false;

  @override
  void onTapProfileItem() async {
    final result = await Get.toNamed(
      PharmacyModuleRoutes.profileAdminPage,
    );

    if (result != null) {
      final UserViewModel user = result as UserViewModel;
      UserProfileModel userProfile = UserProfileModel(
          id: user.id,
          firstName: user.firstName,
          mobile: user.mobile,
          base64Image: user.base64Image);
      CustomScaffoldController.userProfile.value = userProfile;
    }
  }

  @override
  void onTapDrugsItem() {
    Get.toNamed(
      PharmacyModuleRoutes.drugsAdminPage,
    );
  }

  @override
  void onTapPharmaciesItem() {
    Get.toNamed(
      PharmacyModuleRoutes.pharmaciesAdminPage,
    );
  }
}
