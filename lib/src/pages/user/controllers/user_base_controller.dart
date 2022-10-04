import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../generated/locales.g.dart';
import '../repositories/user_repository.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

abstract class UserBaseController extends GetxController {
  final RxBool isLoading = false.obs;

  final bool isAdmin;

  UserBaseController({required this.isAdmin});

  final RxBool passwordIsVisible = false.obs;
  final RxBool confirmPasswordIsVisible = false.obs;

  final RxnString selectedImageUrl = RxnString();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  final UserRepository repository = UserRepository();

  abstract bool addUserPage;

  String? firstNameValidator(final String? value) {
    if (value != null && value.trim().length < 50) {
      return null;
    }
    return LocaleKeys.user_page_firstname_length.tr;
  }

  String? lastNameValidator(final String? value) {
    if (value != null && value.trim().length < 70) {
      return null;
    }
    return LocaleKeys.user_page_firstname_length.tr;
  }

  String? mobileValidator(final String? value) {
    if (value != null && value.trim().length == 11 && value.startsWith('0')) {
      return null;
    }
    return LocaleKeys.user_page_invalid_mobile.tr;
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
    return LocaleKeys.user_page_select_brith_date.tr;
  }

  void onTapCircleImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (selectedImage != null) {
      selectedImageUrl.value = utils.convertImageToBase64(selectedImage.path);
    }
  }

  void onPressedButton(final BuildContext context);
}
