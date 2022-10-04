import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import 'user_base_controller.dart';
import '../../shared/user_view_model.dart';
import '../models/edit_user_dto.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../../generated/locales.g.dart';

class EditUserController extends UserBaseController {
  @override
  bool addUserPage = false;

  EditUserController({required super.isAdmin});

  final Map<String, dynamic> userInfo = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    fillValueTextField();
  }

  void fillValueTextField() {
    firstNameController.text = userInfo['firstName'];
    lastNameController.text = userInfo['lastName'];
    mobileController.text = userInfo['mobile'];
    birthDateController.text = userInfo['birthDate'];
    userNameController.text = userInfo['userName'];
    if (userInfo['base64Image'] != null) {
      selectedImageUrl.value = userInfo['base64Image'];
    }
  }

  @override
  void onPressedButton(final BuildContext context) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      final EditUserDto dto = EditUserDto(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: mobileController.text,
        birthDate: birthDateController.text,
        userName: userNameController.text,
        isAdmin: isAdmin,
        base64Image: selectedImageUrl.value,
      );

      final Either<String, UserViewModel> result =
          await repository.editUser(dto, userInfo['id']);

      await result.fold(_editUserException, _editUserSuccessful);
    }
  }

  Future<void> _editUserSuccessful(final UserViewModel user) async {
    utils.customToast(
      msg: LocaleKeys.user_page_change_info.tr,
      backgroundColor: Colors.teal,
    );

    Get.back(result: user);
  }

  Future<void> _editUserException(final String exception) async {
    utils.customToast(
      msg: LocaleKeys.user_page_change_info_failed.tr,
      backgroundColor: Colors.red,
    );
  }
}
