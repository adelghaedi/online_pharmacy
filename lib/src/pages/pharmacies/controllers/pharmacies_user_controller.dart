import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../shared/models/pharmacy_view_model.dart';
import '../repositories/pharmacies_repository.dart';

class PharmaciesUserController extends GetxController {

  final RxList<PharmacyViewModel> pharmacyList = RxList();

  final RxBool isLoading = false.obs;

  final PharmaciesRepository _repository = PharmaciesRepository();

  @override
  void onInit() {
    super.onInit();
    _getPharmacyList();
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


  void onTapItemPharmacyListView(){

  }

}
