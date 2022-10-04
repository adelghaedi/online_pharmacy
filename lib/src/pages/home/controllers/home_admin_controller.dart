import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../../shared/user_view_model.dart';
import '../../shared/repository.dart';
import '../../../components/customScaffold/controllers/custom_scaffold_controller.dart';

class HomeAdminController extends GetxController {
  final Repository _repository = Repository();

  final Rxn<UserViewModel> adminInfo = Rxn();

  @override
  void onInit() async {
    super.onInit();

    await _getAdminInfo();

    _configCustomScaffold();
  }

  void _configCustomScaffold() {
    CustomScaffoldController.firstNameUser.value = adminInfo.value!.firstName;
    CustomScaffoldController.mobileUser.value = adminInfo.value!.mobile;
    CustomScaffoldController.base64ImageUser.value =
        adminInfo.value!.base64Image;
  }

  void pharmaciesOnPressed() {
    Get.toNamed(PharmacyModuleRoutes.pharmaciesAdminPage);
  }

  void drugsOnPressed() {}

  void profileOnPressed() {}

  void changePasswordOnPressed() {}

  void exitOnPressed() {
    SystemNavigator.pop();
  }

  void onTapProfileItem() async {
    final result = await Get.toNamed(PharmacyModuleRoutes.profileAdminPage);

    if (result != null) {
      UserViewModel user = result as UserViewModel;
      CustomScaffoldController.firstNameUser.value = user.firstName;
      CustomScaffoldController.mobileUser.value = user.mobile;
      CustomScaffoldController.base64ImageUser.value = user.base64Image;
    }
  }

  void onTapDrugsItem() {}

  void onTapPharmaciesItem() {
    Get.toNamed(
      PharmacyModuleRoutes.pharmaciesAdminPage,
      arguments: adminInfo.toJson(),
    );
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
}
