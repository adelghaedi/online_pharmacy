import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../pages/forgot_password/views/reset_password_dialog.dart';
import '../../../pages/forgot_password/controllers/reset_password_controller.dart';
import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../repositories/custom_scaffold_repository.dart';
import '../../../pages/shared/models/user_profile_model.dart';
import '../../../pages/shared/models/user_view_model.dart';

class CustomScaffoldController extends GetxController {
  static Rxn<UserProfileModel> userProfile = Rxn();

  final CustomScaffoldRepository _repository = CustomScaffoldRepository();

  final GetStorage _getStorage = GetStorage();

  static late bool isUserLoggedIn;

  @override
  void onInit() async {
    super.onInit();
    await _checkUserProfile();
  }

  Future<void> _checkUserProfile() async {
    if (userProfile.value == null) {
      if (_getStorage.read<String>('userName') != null &&
          _getStorage.read<String>('password') != null) {
        isUserLoggedIn = true;

        final String userName = _getStorage.read<String>('userName')!;
        final String password = _getStorage.read<String>('password')!;

        await _getUserInfo(userName, password);
      } else {
        isUserLoggedIn = false;
        await _getAdminInfo();
      }
    }
  }

  Future<void> _getUserInfo(
    final String userName,
    final String password,
  ) async {
    Either<String, UserViewModel> result =
        await _repository.getUserInfo(userName, password);

    await result.fold(_getUserException, _getUserSuccessful);
  }

  Future<void> _getUserSuccessful(final UserViewModel user) async {
    userProfile.value = UserProfileModel(
      id: user.id,
      firstName: user.firstName,
      mobile: user.mobile,
      base64Image: user.base64Image,
    );
  }

  Future<void> _getUserException(final String exception) async {}

  Future<void> _getAdminInfo() async {
    Either<String, UserViewModel> result = await _repository.getAdminInfo();

    await result.fold(_getAdminException, _getAdminSuccessful);
  }

  Future<void> _getAdminSuccessful(final UserViewModel user) async {
    userProfile.value = UserProfileModel(
      id: user.id,
      firstName: user.firstName,
      mobile: user.mobile,
      base64Image: user.base64Image,
    );
  }

  Future<void> _getAdminException(final String exception) async {}

  void onPressedExit() {
    SystemNavigator.pop();
  }

  void onPressedChangePassword() {
    Get.offAllNamed(PharmacyModuleRoutes.homeUserPage);
    Get.lazyPut(
      ResetPasswordController.new,
    );
    Get.dialog(
      ResetPasswordDialog(userId: userProfile.value!.id),
    );
  }

  void onPressedProfile() {
    if (isUserLoggedIn) {
      Get.offAllNamed(PharmacyModuleRoutes.homeUserPage);
      Get.toNamed(PharmacyModuleRoutes.profileUserPage);
    } else {
      Get.offAllNamed(PharmacyModuleRoutes.homeAdminPage);
      Get.toNamed(PharmacyModuleRoutes.profileAdminPage);
    }
  }

  void onPressedDrugs() {
    if (isUserLoggedIn) {
      Get.offAllNamed(PharmacyModuleRoutes.homeUserPage);
      Get.toNamed(PharmacyModuleRoutes.drugsUserPage);
    } else {
      Get.offAllNamed(PharmacyModuleRoutes.homeAdminPage);
      Get.toNamed(PharmacyModuleRoutes.drugsAdminPage);
    }
  }

  void onPressedPharmacies() {
    if (isUserLoggedIn) {
      Get.offAllNamed(PharmacyModuleRoutes.homeUserPage);
      Get.toNamed(PharmacyModuleRoutes.pharmaciesUserPage);
    } else {
      Get.offAllNamed(PharmacyModuleRoutes.homeAdminPage);
      Get.toNamed(PharmacyModuleRoutes.pharmaciesAdminPage);
    }
  }

  void onTapBackIcon(final bool isHomeAdminPage, final bool isLoginPage) {
    if (isHomeAdminPage || isLoginPage) {
      SystemNavigator.pop();
    } else {
      Get.back();
    }
  }
}
