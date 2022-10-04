import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../generated/locales.g.dart';
import '../../../../pharmacy.dart';
import '../../shared/user_view_model.dart';
import '../../shared/repository.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class LoginController extends GetxController {
  final RxBool passwordIsVisible = false.obs;
  final RxBool isLoading = false.obs;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  final Repository _repository = Repository();

  final GetStorage _getStorage = GetStorage();

  String? userNameValidator(final String? value) {
    if (value != null && value.trim().length < 8) {
      return LocaleKeys.login_page_username_length.tr;
    }
    return null;
  }

  String? passwordValidator(final String? value) {
    if (value != null && value.trim().length < 6) {
      return LocaleKeys.login_page_password_length.tr;
    } else if (!value!.contains('#')) {
      return LocaleKeys.login_page_password_contain_sharp.tr;
    }
    return null;
  }

  void togglePasswordVisibility() {
    passwordIsVisible.value = !passwordIsVisible.value;
  }

  void onPressedForgotPassword() {
    Get.toNamed(PharmacyModuleRoutes.forgotPasswordPage);
  }

  void onPressedLogin(final BuildContext context) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      Either<String, UserViewModel> result = await _repository.getUserInfo(
        userNameController.text,
        passwordController.text,
      );

      result.fold(_loginException, _loginSuccessful);
    }
  }

  void _loginSuccessful(final UserViewModel user) {
    if (user.isAdmin) {
      isLoading.value = false;

      utils.customToast(
        msg: LocaleKeys.login_page_login_successful.tr,
      );

      Get.offAndToNamed(
        PharmacyModuleRoutes.homeAdminPage,
      );
    } else {
      isLoading.value = false;

      _getStorage.write('userName', userNameController.text);
      _getStorage.write('password', passwordController.text);

      utils.customToast(
        msg: LocaleKeys.login_page_login_successful.tr,
      );

      Get.offAndToNamed(PharmacyModuleRoutes.homePage);
    }
  }

  void _loginException(final String exception) {
    isLoading.value = false;
    utils.customToast(
        msg: LocaleKeys.login_page_login_not_successful.tr,
        backgroundColor: Colors.red);
  }

  void onPressedSignUp() {
    Get.toNamed(PharmacyModuleRoutes.addUserPage);
  }

  void onTapBackIcon() {
    SystemNavigator.pop();
  }
}
