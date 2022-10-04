import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/src/pages/forgot_password/controllers/reset_password_controller.dart';
import 'package:pharmacy/src/pages/forgot_password/views/reset_password_dialog.dart';
import 'package:toast/toast.dart';

import '../../../../generated/locales.g.dart';
import '../repositories/forgot_password_repository.dart';
import '../../shared/user_view_model.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final ForgotPasswordRepository _repository = ForgotPasswordRepository();

  final RxBool isLoading = false.obs;

  String? userNameValidator(final String? value) {
    if (value != null && value.trim().length < 8) {
      return LocaleKeys.login_page_username_length.tr;
    }
    return null;
  }

  String? mobileValidator(final String? value) {
    if (value != null && value.trim().length == 11 && value.startsWith('0')) {
      return null;
    }
    return LocaleKeys.user_page_invalid_mobile.tr;
  }

  void onTapBackIcon() {
    Get.back();
  }

  void onPressedContinueButton(final BuildContext context) async {
    ToastContext().init(context);
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      Either<String, UserViewModel> result = await _repository.getUserInfo(
        userNameController.text,
        mobileController.text,
      );

      result.fold(_findUserException, _findUserSuccessful);
    }
  }

  void _findUserSuccessful(final UserViewModel user) {
    isLoading.value = false;
    Get.lazyPut(ResetPasswordController.new);
    Get.dialog(
      barrierDismissible: false,
      ResetPasswordDialog(
        userId: user.id,
      ),
    );
  }

  void _findUserException(final String exception) {
    isLoading.value = false;
    utils.customToast(
      msg: LocaleKeys.forgot_password_page_not_current_information.tr,
      backgroundColor: Colors.red,
    );
  }
}
