import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../../../../generated/locales.g.dart';
import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../../shared/models/user_view_model.dart';
import '../models/insert_user_dto.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import 'user_base_controller.dart';

class AddUserController extends UserBaseController {
  @override
  bool addUserPage = true;

  AddUserController({required super.isAdmin});

  @override
  void onPressedButton(final BuildContext context) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final InsertUserDto dto = InsertUserDto(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: mobileController.text,
        birthDate: birthDateController.text,
        userName: userNameController.text,
        password: passwordController.text,
        isAdmin: isAdmin,
        base64Image: selectedImageUrl.value,
      );

      final Either<String, UserViewModel> result =
          await repository.addUser(dto);

      result.fold(_addUserException, _addUserSuccessful);
    }
  }

  void _addUserSuccessful(final UserViewModel user) {
    if (isAdmin) {
      isLoading.value = false;
      utils.customToast(
          msg: LocaleKeys.user_page_sign_up_successful.tr,
          backgroundColor: Colors.teal);
      Get.offAndToNamed(PharmacyModuleRoutes.loginPage);
    } else {
      isLoading.value = false;
      utils.customToast(
          msg: LocaleKeys.user_page_sign_up_successful.tr,
          backgroundColor: Colors.teal);
      Get.offNamed(PharmacyModuleRoutes.loginPage);
    }
  }

  void _addUserException(final String exception) {
    isLoading.value = false;
    utils.customToast(
      msg: LocaleKeys.user_page_sign_up_not_successful.tr,
      backgroundColor: Colors.red,
    );
  }
}
