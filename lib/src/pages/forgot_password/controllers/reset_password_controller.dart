import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../../../../generated/locales.g.dart';
import '../models/edit_password_dto.dart';
import '../repositories/reset_password_repository.dart';
import '../../shared/user_view_model.dart';
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

  final ResetPasswordRepository _repository = ResetPasswordRepository();

  void onPressedSubmit(final BuildContext context, final int id) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final Either<String, UserViewModel> result = await _repository
          .changeUserPassword(id, EditPasswordDto(newPasswordController.text));

      result.fold(
        _changePasswordException,
        _changePasswordSuccessful,
      );
    }
  }

  void _changePasswordSuccessful(final UserViewModel user) {
    isLoading.value = false;
    utils.customToast(
        msg: LocaleKeys.reset_password_dialog_change_password_successfully.tr);
    Get.offNamed(PharmacyModuleRoutes.loginPage);
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
