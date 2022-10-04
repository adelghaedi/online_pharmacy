import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../infrastructure/routes/pharmacy_module_routes.dart';

class CustomScaffoldController extends GetxController {

  static final RxString firstNameUser = ''.obs;
  static final RxString mobileUser = ''.obs;
  static final RxnString base64ImageUser = RxnString();

  void onPressedExit() {
    SystemNavigator.pop();
  }

  void onPressedChangePassword() {}

  void onPressedProfile() {
    Get.toNamed(PharmacyModuleRoutes.profileAdminPage);
  }

  void onPressedDrugs() {}

  void onPressedPharmacies() {
    Get.toNamed(PharmacyModuleRoutes.pharmaciesAdminPage);
  }

  void onTapBackIcon(final bool isHomeAdminPage, final bool isLoginPage) {
    if (isHomeAdminPage || isLoginPage) {
      SystemNavigator.pop();
    } else {
      Get.back();
    }
  }
}
