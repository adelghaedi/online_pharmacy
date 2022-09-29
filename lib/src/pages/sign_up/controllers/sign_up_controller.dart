import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:toast/toast.dart';

import '../../../../src/infrastructure/routes/pharmacy_module_routes.dart';
import '../../../pages/sign_up/models/insert_user_dto.dart';
import '../../shared/user_view_model.dart';
import '../../../../generated/locales.g.dart';
import '../repositories/sign_up_repository.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class SignUpController extends GetxController {
  final RxBool isLoading = false.obs;

  final bool isAdmin;

  SignUpController({required this.isAdmin});

  final RxBool passwordIsVisible = false.obs;
  final RxBool confirmPasswordIsVisible = false.obs;

  final RxString selectedImageUrl = ''.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  final SignUpRepository _repository = SignUpRepository();

  void onTapBackIcon() {
    Get.back();
  }

  String? firstNameValidator(final String? value) {
    if (value != null && value.trim().length < 50) {
      return null;
    }
    return LocaleKeys.sign_up_page_firstname_length.tr;
  }

  String? lastNameValidator(final String? value) {
    if (value != null && value.trim().length < 70) {
      return null;
    }
    return LocaleKeys.sign_up_page_firstname_length.tr;
  }

  String? mobileValidator(final String? value) {
    if (value != null && value.trim().length == 11 && value.startsWith('0')) {
      return null;
    }
    return LocaleKeys.sign_up_page_invalid_mobile.tr;
  }

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

  String? confirmPasswordValidator(final String? value) {
    if (value != null && value.trim() != passwordController.text) {
      return LocaleKeys.reset_password_dialog_not_match.tr;
    }
    return null;
  }

  void togglePasswordVisibility() {
    passwordIsVisible.value = !passwordIsVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordIsVisible.value = !confirmPasswordIsVisible.value;
  }

  Future<void> onTapBirthDateTextField(final BuildContext context) async {
    final int firstYear = Jalali.now().year - 80;
    final int lastYear = Jalali.now().year - 18;

    final Jalali? birthDate = await showPersianDatePicker(
      context: context,
      initialDate: Jalali(lastYear),
      firstDate: Jalali(firstYear, Jalali.now().month, Jalali.now().day),
      lastDate: Jalali(lastYear, Jalali.now().month, Jalali.now().day),
    );

    if (birthDate != null) {
      birthDateController.text = birthDate.formatCompactDate();
    }
  }

  String? birthDateValidator(final String? value) {
    if (value != null && value.trim().length == 10) {
      return null;
    }
    return LocaleKeys.sign_up_page_select_brith_date.tr;
  }

  void onPressedSignUp(final BuildContext context) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      Uint8List? imageBytes;
      if (selectedImageUrl.value.isNotEmpty) {
        imageBytes = File(selectedImageUrl.value).readAsBytesSync();
      }

      final InsertUserDto dto = InsertUserDto(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        mobile: mobileController.text,
        birthDate: birthDateController.text,
        userName: userNameController.text,
        password: passwordController.text,
        isAdmin: isAdmin,
        imageBytes: imageBytes,
      );

      final Either<String, UserViewModel> result =
          await _repository.signUpUser(dto);

      result.fold(_signUpException, _signUpSuccessful);
    }
  }

  void _signUpSuccessful(final UserViewModel user) {
    if (isAdmin) {
      isLoading.value = false;
      utils.customToast(
          msg: LocaleKeys.sign_up_page_sign_up_successful.tr,
          backgroundColor: Colors.teal);
      Get.offAndToNamed(PharmacyModuleRoutes.loginPage);
    } else {
      isLoading.value = false;
      utils.customToast(
          msg: LocaleKeys.sign_up_page_sign_up_successful.tr,
          backgroundColor: Colors.teal);
      Get.offNamed(PharmacyModuleRoutes.loginPage);
    }
  }

  void _signUpException(final String exception) {
    isLoading.value = false;
    utils.customToast(
      msg: LocaleKeys.sign_up_page_sign_up_not_successful.tr,
      backgroundColor: Colors.red,
    );
  }

  void onTapImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );

    if (selectedImage != null) {
      selectedImageUrl.value = selectedImage.path;
    }
  }
}
