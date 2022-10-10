import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../shared/models/pharmacy_view_model.dart';
import '../models/pharmacy_drugs_update_dto.dart';
import '../views/add_drug_to_pharmacy_dialog.dart';
import '../controllers/add_drug_to_pharmacy_controller.dart';
import '../../shared/models/drug_pharmacy_view_model.dart';
import '../repositories/pharmacy_drug_management_repository.dart';

class PharmacyDrugsManagementController extends GetxController {
  final int _pharmacyId = Get.arguments;

  final RxList<DrugPharmacyViewModel> pharmacyDrugList = RxList();

  final RxList<bool> showDrugSwitchesValue = RxList();

  final PharmacyDrugManagementRepository _repository =
      PharmacyDrugManagementRepository();

  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _getPharmacyInfo();
  }

  Future<void> _getPharmacyInfo() async {
    isLoading.value = true;

    final Either<String, PharmacyViewModel> result =
        await _repository.getPharmacyWithId(_pharmacyId);

    await result.fold(_getPharmacyException, _getPharmacySuccessful);
  }

  Future<void> _getPharmacySuccessful(final PharmacyViewModel pharmacy) async {
    isLoading.value = false;

    pharmacyDrugList.value = pharmacy.drugs;

    showDrugSwitchesValue.value = List.generate(
      pharmacyDrugList.length,
      (index) => pharmacyDrugList[index].showDrugPharmacy,
    );
  }

  Future<void> _getPharmacyException(final String exception) async {}

  void onChangedShowDrugSwitch(final bool value, final int index) async {
    pharmacyDrugList[index].showDrugPharmacy = value;

    final Either<String, PharmacyViewModel> result =
        await _repository.pharmacyDrugsUpdate(
      _pharmacyId,
      PharmacyDrugsUpdateDto(
        drugs: pharmacyDrugList,
      ),
    );

    result.fold(
      _pharmacyDrugsUpdateException,
      (final PharmacyViewModel pharmacy) => _pharmacyDrugsUpdateSuccessful(
        index,
        value,
      ),
    );
  }

  Future<void> _pharmacyDrugsUpdateException(final String exception) async {}

  Future<void> _pharmacyDrugsUpdateSuccessful(
    final int index,
    final bool value,
  ) async {
    showDrugSwitchesValue[index] = value;
  }

  void onPressedFloatActionButton() async {
    Get.lazyPut(AddDrugToPharmacyController.new);

    final result = await Get.dialog(
      const AddDrugToPharmacyDialog(),
      arguments: [
        {
          'drugs': pharmacyDrugList.map((element) => element.toJson()).toList(),
        },
        {
          'pharmacyId': _pharmacyId,
        }
      ],
    );

    if (result != null) {
      final DrugPharmacyViewModel drugPharmacy =
          result as DrugPharmacyViewModel;

      pharmacyDrugList.add(drugPharmacy);
      showDrugSwitchesValue.add(drugPharmacy.showDrugPharmacy);
    }
  }
}
