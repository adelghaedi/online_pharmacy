import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../models/pharmacy_insert_dto.dart';
import '../../shared/models/pharmacy_view_model.dart';
import '../controllers/pharmacy_base_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../../generated/locales.g.dart';

class AddPharmacyController extends PharmacyBaseController {
  @override
  bool isAddPharmacyPage = true;

  @override
  Future<void> onPressedButton(
    final BuildContext context,
  ) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final PharmacyInsertDto dto = PharmacyInsertDto(
          name: pharmacyNameController.text,
          address: addressController.text,
          doctorName: doctorNameController.text,
          dateOfEstablishment: dateOfEstablishmentController.text,
          base64Image: selectedImageUrl.value,
          drugs: []);

      final Either<String, PharmacyViewModel> result =
          await repository.insertPharmacy(dto);

      result.fold(
        _insertPharmacyException,
        _insertPharmacySuccessful,
      );
    }
  }

  Future<void> _insertPharmacySuccessful(
      final PharmacyViewModel pharmacy) async {
    isLoading.value = false;

    utils.customToast(
      msg: LocaleKeys.pharmacy_page_add_pharmacy_successful.tr,
    );

    Get.back(
      result: pharmacy,
    );
  }

  Future<void> _insertPharmacyException(final String exception) async {
    utils.customToast(
      msg: LocaleKeys.pharmacy_page_add_pharmacy_failed.tr,
      backgroundColor: Colors.red,
    );
  }
}
