import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../shared/models/pharmacy_view_model.dart';
import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../repositories/pharmacies_repository.dart';

class PharmaciesAdminController extends GetxController {
  final PharmaciesRepository _repository = PharmaciesRepository();

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

  Future<void> _getPharmaciesException(final String exception) async {}

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
}
