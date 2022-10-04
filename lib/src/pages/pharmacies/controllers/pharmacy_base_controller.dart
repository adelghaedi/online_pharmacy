import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../generated/locales.g.dart';
import '../repositories/pharmacies_repository.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

abstract class PharmacyBaseController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController pharmacyNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController dateOfEstablishmentController =
      TextEditingController();

  final RxnString selectedImageUrl = RxnString();

  final PharmaciesRepository repository = PharmaciesRepository();

  final RxBool isLoading = false.obs;

  abstract bool isAddPharmacyPage;


  String? pharmacyNameValidator(final String? value) {
    if (value != null && value.trim().length > 100) {
      return LocaleKeys.pharmacy_page_pharmacy_name_length.tr;
    }
    return null;
  }

  String? addressValidator(final String? value) {
    if (value != null && value.trim().length > 250) {
      return LocaleKeys.pharmacy_page_address_length.tr;
    }
    return null;
  }

  String? doctorNameValidator(final String? value) {
    if (value != null && value.trim().length > 120) {
      return LocaleKeys.pharmacy_page_doctor_name_length.tr;
    }
    return null;
  }

  String? dateOfEstablishmentValidator(final String? value) {
    if (value != null && value.trim().length == 10) {
      return null;
    }
    return LocaleKeys.pharmacy_page_select_date_of_establishment.tr;
  }

  Future<void> onTapDateOfEstablishmentTextField(
      final BuildContext context) async {
    final int firstYear = Jalali.now().year - 80;

    final Jalali? dateOfEstablishment = await showPersianDatePicker(
      context: context,
      initialDate: Jalali(Jalali.now().year),
      firstDate: Jalali(firstYear),
      lastDate: Jalali(Jalali.now().year),
    );

    if (dateOfEstablishment != null) {
      dateOfEstablishmentController.text =
          dateOfEstablishment.formatCompactDate();
    }
  }

  void onTapCircleImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (selectedImage != null) {
      selectedImageUrl.value = utils.convertImageToBase64(selectedImage.path);
    }
  }

  Future<void> onPressedButton(final BuildContext context);
}
