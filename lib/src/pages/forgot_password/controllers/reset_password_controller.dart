import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toast/toast.dart';

import '../../../../generated/locales.g.dart';
import '../models/password_update_dto.dart';
import '../repositories/forgot_password_repository.dart';
import '../../shared/models/user_view_model.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../infrastructure/routes/pharmacy_module_routes.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool newPasswordIsVisible = false.obs;

  final RxBool confirmPasswordIsVisible = false.obs;

  final RxBool isLoading = false.obs;

  final ForgotPasswordRepository _repository = ForgotPasswordRepository();

  final GetStorage _storage = GetStorage();

  void onPressedSubmit(
    final BuildContext context,
    final int id,
    final bool comeFromLoginPage,
  ) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final Either<String, UserViewModel> result =
          await _repository.changeUserPassword(
              id, PasswordUpdateDto(newPasswordController.text));

      result.fold(
        _changePasswordException,
        (final UserViewModel user) => _changePasswordSuccessful(
          user,
          comeFromLoginPage,
        ),
      );
    }
  }

  void _changePasswordSuccessful(
    final UserViewModel user,
    final bool comeFromLoginPage,
  ) {
    isLoading.value = false;
    utils.customToast(
        msg: LocaleKeys.reset_password_dialog_change_password_successfully.tr);
    if (comeFromLoginPage) {
      Get.offAllNamed(PharmacyModuleRoutes.loginPage);
    } else {
      _storage.remove('password');
      _storage.write('password', user.password);
      Get.back();
    }
  }

  void _changePasswordException(final String exception) {
    isLoading.value = false;
    utils.customToast(
      msg: LocaleKeys.reset_password_dialog_change_password_not_successful.tr,
      backgroundColor: Colors.red,
    );
  }

  void toggleNewPasswordVisibility() {
    newPasswordIsVisible.value = !newPasswordIsVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordIsVisible.value = !confirmPasswordIsVisible.value;
  }

  String? newPasswordValidator(final String? value) {
    if (value != null && value.trim().length < 6) {
      return LocaleKeys.login_page_password_length.tr;
    } else if (!value!.contains('#')) {
      return LocaleKeys.login_page_password_contain_sharp.tr;
    }
    return null;
  }

  String? confirmPasswordValidator(final String? value) {
    if (value != null && value.trim() != newPasswordController.text) {
      return LocaleKeys.reset_password_dialog_not_match.tr;
    }
    return null;
  }
}
