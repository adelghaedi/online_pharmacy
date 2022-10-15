import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../../../../../generated/locales.g.dart';
import '../controllers/drug_base_controller.dart';
import '../models/drug_insert_dto.dart';
import '../../../shared/models/drug_view_model.dart';
import '../../../../infrastructure/utils/utils.dart' as utils;

class AddDrugController extends DrugBaseController {
  @override
  bool isAddDrugDialog = true;

  @override
  Future<void> onPressedButton(final BuildContext context) async {
    ToastContext().init(context);
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      DrugInsertDto dto = DrugInsertDto(
        name: drugNameController.text,
        manufacturingCompanyName: manufacturingCompanyNameController.text,
        base64Image: selectedImageUrl.value,
      );

      final Either<String, DrugViewModel> result =
          await repository.insertDrug(dto);

      await result.fold(_insertDrugException, _insertDrugSuccessful);
    }
  }

  Future<void> _insertDrugSuccessful(final DrugViewModel drug) async {
    isLoading.value = false;

    utils.customToast(
      msg: LocaleKeys.drug_dialog_add_drug_successful.tr,
    );

    Get.back(result: drug);
  }

  Future<void> _insertDrugException(final String exception) async {
    utils.customToast(
      msg: LocaleKeys.drug_dialog_add_drug_failed.tr,
      backgroundColor: Colors.red,
    );
  }
}
