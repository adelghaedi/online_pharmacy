import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../../../pages/shared/repository.dart';
import '../../../pages/shared/user_view_model.dart';

class ProfileController extends GetxController {
  final Repository _repository = Repository();

  final Rxn<UserViewModel> adminInfo = Rxn();

  @override
  void onInit() {
    super.onInit();
    _getAdminInfo();
  }

  Future<void> _getAdminInfo() async {
    final Either<String, UserViewModel> result =
        await _repository.getAdminInfo();
    await result.fold(
      _getAdminInfoException,
      _getAdminInfoSuccessful,
    );
  }

  Future<void> _getAdminInfoSuccessful(final UserViewModel admin) async {
    adminInfo.value = admin;
  }

  Future<void> _getAdminInfoException(final String exception) async {}

  void onPressedEditInfo() async {
    final result = await Get.toNamed(
      PharmacyModuleRoutes.editAdminPage,
      arguments: adminInfo.toJson(),
    );
    if (result != null) {
      Get.back(
        result: result,
      );
    }
  }
}
