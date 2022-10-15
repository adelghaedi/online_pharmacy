import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../models/pharmacy_drugs_update_dto.dart';
import '../../shared/models/pharmacy_drug_view_model.dart';
import '../../shared/models/pharmacy_view_model.dart';
import '../../../../generated/locales.g.dart';
import '../../shared/models/drug_view_model.dart';
import '../repositories/pharmacy_drug_management_repository.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class AddDrugToPharmacyController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController priceController = TextEditingController();

  final PharmacyDrugManagementRepository _repository =
      PharmacyDrugManagementRepository();

  final RxList<DrugViewModel> drugList = RxList();

  final RxBool isLoading = false.obs;

  final RxBool isSubmitInfo = false.obs;

  RxnInt valueDrugsDropDownButton = RxnInt();

  @override
  void onInit() async {
    super.onInit();
    await _getDrugList();
  }

  Future<void> _getDrugList() async {
    isLoading.value = true;

    Either<String, List<DrugViewModel>> result =
        await _repository.getDrugsInfo();

    result.fold(_getDrugsException, _getDrugsSuccessful);
  }

  Future<void> _getDrugsSuccessful(final List<DrugViewModel> drugs) async {
    isLoading.value = false;

    drugList.value = drugs;
  }

  Future<void> _getDrugsException(final String exception) async {}

  Future<void> onPressedSubmit(final BuildContext context) async {
    ToastContext().init(context);

    if (formKey.currentState!.validate()) {
      isSubmitInfo.value = true;

      final PharmacyDrugViewModel selectedDrug = PharmacyDrugViewModel(
        drug: drugList.firstWhere(
            (element) => element.id == valueDrugsDropDownButton.value),
        price: priceController.text,
        showPharmacyDrug: true,
      );

      final List<PharmacyDrugViewModel> drugs =
          (Get.arguments[0]['drugs'] as List<Map<String, dynamic>>)
              .map(
                (json) => PharmacyDrugViewModel.fromJson(json),
              )
              .toList();

      drugs.add(
        selectedDrug,
      );

      final Either<String, PharmacyViewModel> result =
          await _repository.pharmacyDrugsUpdate(
        Get.arguments[1]['pharmacyId'],
        PharmacyDrugsUpdateDto(drugs: drugs),
      );

      await result.fold(
        _pharmacyDrugsUpdateException,
        (final PharmacyViewModel pharmacy) =>
            _pharmacyDrugsUpdateSuccessful(selectedDrug),
      );
    }
  }

  Future<void> _pharmacyDrugsUpdateException(final String exception) async {
    utils.customToast(
      msg:
          LocaleKeys.add_drug_to_pharmacy_dialog_add_drug_to_pharmacy_failed.tr,
      backgroundColor: Colors.red,
    );

    Get.back();
  }

  Future<void> _pharmacyDrugsUpdateSuccessful(
    final PharmacyDrugViewModel drugPharmacy,
  ) async {
    isSubmitInfo.value = false;

    utils.customToast(
      msg: LocaleKeys
          .add_drug_to_pharmacy_dialog_add_drug_to_pharmacy_successful.tr,
    );

    Get.back(result: drugPharmacy);
  }

  void onPressedDropDownButton(final int? value) {
    valueDrugsDropDownButton.value = value;
  }

  void onChangedPriceTextField(String value) {
    value = formatNumber(value.replaceAll(',', ''));
    priceController.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }

  String formatNumber(String s) =>
      NumberFormat.decimalPattern('en').format(int.parse(s));

  String? drugsValidator(final int? value) {
    if (value != null) {
      return null;
    }
    return LocaleKeys.add_drug_to_pharmacy_dialog_select_drug.tr;
  }

  String? priceValidator(final String? value) {
    if (value != null && value.trim().length >= 4) {
      return null;
    }
    return LocaleKeys.add_drug_to_pharmacy_dialog_price_validate.tr;
  }
}
