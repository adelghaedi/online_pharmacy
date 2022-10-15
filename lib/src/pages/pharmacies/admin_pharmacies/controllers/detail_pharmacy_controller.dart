import 'package:get/get.dart';

import '../../../../infrastructure/routes/pharmacy_module_routes.dart';

class DetailPharmacyController extends GetxController {
  final Map<String, dynamic> pharmacyInfo = Get.arguments;

  void onPressedEditInfo() async {
    final result = await Get.toNamed(
      PharmacyModuleRoutes.editPharmacyAdminPage,
      arguments: pharmacyInfo,
    );

    if (result != null) {
      Get.back(
        result: result,
      );
    }
  }
}
