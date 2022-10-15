import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../controllers/drug_base_controller.dart';
import '../models/drug_update_dto.dart';
import '../../../shared/models/drug_view_model.dart';
import '../../../../infrastructure/utils/utils.dart' as utils;
import '../../../../../generated/locales.g.dart';

class EditDrugController extends DrugBaseController {
  final Map<String, dynamic> drugInfo = Get.arguments;

  @override
  bool isAddDrugDialog = false;

  @override
  void onInit() {
    super.onInit();
    _fillValueTextField();
  }

  void _fillValueTextField() {
    drugNameController.text = drugInfo['name'];
    manufacturingCompanyNameController.text =
        drugInfo['manufacturingCompanyName'];
    selectedImageUrl.value = drugInfo['base64Image'];
  }

  @override
  Future<void> onPressedButton(final BuildContext context) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final DrugUpdateDto dto = DrugUpdateDto(
        name: drugNameController.text,
        manufacturingCompanyName: manufacturingCompanyNameController.text,
        base64Image: selectedImageUrl.value,
      );

      final Either<String, DrugViewModel> result =
          await repository.updateDrugWithId(
        drugInfo['id'],
        dto,
      );

      await result.fold(_updateDrugException, _updateDrugSuccessful);
    }
  }

  Future<void> _updateDrugSuccessful(final DrugViewModel drug) async {
    isLoading.value = false;

    utils.customToast(
      msg: LocaleKeys.drug_dialog_change_drug_successful.tr,
    );

    Get.back(
      result: drug,
    );
  }

  Future<void> _updateDrugException(final String exception) async {
    isLoading.value = false;

    utils.customToast(
      msg: LocaleKeys.drug_dialog_change_drug_failed.tr,
      backgroundColor: Colors.red,
    );

    Get.back();
  }
}
