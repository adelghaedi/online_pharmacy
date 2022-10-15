import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../shared/models/pharmacy_view_model.dart';
import '../repositories/pharmacies_user_repository.dart';
import '../../../../infrastructure/routes/pharmacy_module_routes.dart';

class PharmaciesUserController extends GetxController {
  final RxList<PharmacyViewModel> pharmacyList = RxList();

  final RxBool isLoading = false.obs;

  final PharmaciesUserRepository _repository = PharmaciesUserRepository();

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

  Future<void> _getPharmaciesException(final String exception) async {}

  Future<void> _getPharmaciesSuccessful(
      final List<PharmacyViewModel> pharmacies) async {
    isLoading.value = false;
    pharmacyList.value = pharmacies;
  }

  void onTapItemPharmacyListView(final int index) {
    Get.toNamed(
      PharmacyModuleRoutes.drugPurchasePage,
      arguments: pharmacyList[index].toJson(),
    );
  }

  void onPressedFilterButton(
    final Map<String, String> searchInfo,
  ) async {
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
    final List<PharmacyViewModel> pharmacies,
  ) async {
    pharmacyList.value = pharmacies;
  }

  Future<void> _advanceSearchPharmaciesException(
      final String exception) async {}

  void onPressedSearchIcon(final String pharmacyName) async {
    final Either<String, List<PharmacyViewModel>> result =
        await _repository.searchPharmacies(
      pharmacyName: pharmacyName,
    );
    result.fold(
      _searchPharmaciesException,
      _searchPharmaciesSuccessful,
    );
  }

  Future<void> _searchPharmaciesSuccessful(
      final List<PharmacyViewModel> pharmacies) async {
    pharmacyList.value = pharmacies;
  }

  Future<void> _searchPharmaciesException(final String exception) async {}
}
