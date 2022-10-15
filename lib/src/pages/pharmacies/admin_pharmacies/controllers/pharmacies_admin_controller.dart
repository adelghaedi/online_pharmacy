import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../shared/models/pharmacy_view_model.dart';
import '../../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../repositories/pharmacies_admin_repository.dart';

class PharmaciesAdminController extends GetxController {
  final PharmaciesAdminRepository _repository = PharmaciesAdminRepository();

  final RxList pharmacyList = RxList();

  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _getPharmacyList();
  }

  Future<void> _getPharmacyList() async {
    isLoading.value = true;
    Either<String, List<PharmacyViewModel>> result =
        await _repository.getPharmaciesInfo();
    await result.fold(_getPharmaciesException, _getPharmaciesSuccessful);
  }

  Future<void> _getPharmaciesException(final String exception) async {
  }

  Future<void> _getPharmaciesSuccessful(
      final List<PharmacyViewModel> pharmacies) async {
    isLoading.value = false;
    pharmacyList.value = pharmacies;
  }

  void onPressedFloatingActionButton() async {
    final pharmacy = await Get.toNamed(
      PharmacyModuleRoutes.addPharmacyAdminPage,
    );

    if (pharmacy != null) {
      pharmacyList.add(pharmacy as PharmacyViewModel);
    }
  }

  Future<void> onPressedDeleteIcon(final int pharmacyId) async {
    final Either<String, dynamic> result =
        await _repository.removePharmacyWithId(pharmacyId);
    await result.fold(
      _removePharmacyException,
      (final dynamic data) => _removePharmacySuccessful(
        pharmacyId,
      ),
    );
  }

  Future<void> _removePharmacySuccessful(final int id) async {
    pharmacyList.removeWhere((element) => element.id == id);
  }

  Future<void> _removePharmacyException(final String exception) async {}

  void onPressedDetailIcon(final Map<String, dynamic> pharmacyInfo) async {
    final result = await Get.toNamed(
      PharmacyModuleRoutes.detailPharmacyAdminPage,
      arguments: pharmacyInfo,
    );

    if (result != null) {
      final PharmacyViewModel pharmacy = result as PharmacyViewModel;

      final int itemUpdatedIndex =
          pharmacyList.indexWhere((element) => element.id == pharmacy.id);
      pharmacyList.removeAt(itemUpdatedIndex);
      pharmacyList.insert(itemUpdatedIndex, result);
    }
  }

  void onPressedDrugsManagement(final Map<String, dynamic> pharmacyInfo) async {
    await Get.toNamed(
      PharmacyModuleRoutes.pharmacyDrugManagementPage,
      arguments: pharmacyInfo['id'],
    );
  }

  void onPressedSearchIcon(final String pharmacyName) async {
    final Either<String, List<PharmacyViewModel>> result =
        await _repository.searchPharmacies(
      pharmacyName: pharmacyName,
    );

    result.fold(_searchPharmaciesException, _searchPharmaciesSuccessful);
  }

  Future<void> _searchPharmaciesSuccessful(
    final List<PharmacyViewModel> pharmacies,
  ) async {
    pharmacyList.value = pharmacies;
  }

  Future<void> _searchPharmaciesException(final String exception) async {}

  void onPressedFilterButton(final Map<String, String> searchInfo) async {
    final Either<String, List<PharmacyViewModel>> result =
        await _repository.searchPharmacies(
      pharmacyName: searchInfo['pharmacyName'] as String,
      doctorName: searchInfo['doctorName'] as String,
      fromDate: searchInfo['fromDate'] as String,
      untilDate: searchInfo['untilDate'] as String,
    );

    await result.fold(
      _advanceSearchPharmaciesException,
      _advanceSearchPharmaciesSuccessful,
    );

    Get.back();
  }

  Future<void> _advanceSearchPharmaciesSuccessful(
      final List<PharmacyViewModel> pharmacies) async {
    pharmacyList.value = pharmacies;
  }

  Future<void> _advanceSearchPharmaciesException(
      final String exception) async {}
}
