import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../../shared/models/pharmacy_view_model.dart';
import '../models/pharmacy_update_dto.dart';
import '../controllers/pharmacy_base_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../../generated/locales.g.dart';
import '../../shared/models/drug_pharmacy_view_model.dart';

class EditPharmacyController extends PharmacyBaseController {
  final Map<String, dynamic> pharmacyInfo = Get.arguments;

  @override
  bool isAddPharmacyPage = false;

  @override
  void onInit() {
    super.onInit();

    _fillValueTextField();
  }

  void _fillValueTextField() {
    pharmacyNameController.value = TextEditingValue(text: pharmacyInfo['name']);
    addressController.value = TextEditingValue(text: pharmacyInfo['address']);
    doctorNameController.value =
        TextEditingValue(text: pharmacyInfo['doctorName']);
    dateOfEstablishmentController.value =
        TextEditingValue(text: pharmacyInfo['dateOfEstablishment']);
    if (pharmacyInfo['base64Image'] != null) {
      selectedImageUrl.value = pharmacyInfo['base64Image'];
    }
  }

  @override
  Future<void> onPressedButton(final BuildContext context) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final PharmacyUpdateDto dto = PharmacyUpdateDto(
        name: pharmacyNameController.text,
        address: addressController.text,
        doctorName: doctorNameController.text,
        dateOfEstablishment: dateOfEstablishmentController.text,
        base64Image: selectedImageUrl.value,
        drugs: (pharmacyInfo['drugs'] as List<dynamic>)
            .map(
              (json) => DrugPharmacyViewModel.fromJson(json),
            )
            .toList(),
      );

      final Either<String, PharmacyViewModel> result =
          await repository.updatePharmacyWithId(
        pharmacyInfo['id'],
        dto,
      );

      await result.fold(
          _updatePharmacyInfoException, _updatePharmacyInfoSuccessful);
    }
  }

  Future<void> _updatePharmacyInfoSuccessful(
      final PharmacyViewModel pharmacy) async {
    isLoading.value = false;

    utils.customToast(
      msg: LocaleKeys.user_page_change_info.tr,
    );

    Get.back(
      result: pharmacy,
    );
  }

  Future<void> _updatePharmacyInfoException(final String exception) async {
    utils.customToast(
      msg: LocaleKeys.user_page_change_info_failed.tr,
      backgroundColor: Colors.red,
    );
  }
}
