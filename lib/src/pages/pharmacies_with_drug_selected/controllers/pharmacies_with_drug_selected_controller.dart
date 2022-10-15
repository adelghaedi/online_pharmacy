import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../shared/models/user_profile_model.dart';
import '../../shared/models/user_drugs_update_dto.dart';
import '../../../components/custom_scaffold/controllers/custom_scaffold_controller.dart';
import '../../shared/models/pharmacy_view_model.dart';
import '../../shared/models/user_view_model.dart';
import '../repositories/pharmacies_with_drug_selected_repository.dart';
import '../../shared/models/pharmacy_drug_view_model.dart';
import '../../shared/models/user_drug_view_model.dart';

class PharmaciesWithDrugSelectedController extends GetxController {
  final int userId = CustomScaffoldController.userProfile.value!.id;

  final RxList<PharmacyViewModel> pharmacyList = RxList();

  final int drugId = Get.arguments['drugId'];

  final String drugName = Get.arguments['drugName'];

  final PharmaciesWithDrugSelectedRepository _repository =
      PharmaciesWithDrugSelectedRepository();

  final RxBool isLoading = false.obs;

  RxList<UserDrugViewModel> userDrugList = RxList();

  RxList<int> numberOfDrugPurchasedList = RxList();

  RxList<UserDrugViewModel> similarDrugList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await _getPharmacyList();
    _fillNumberOfDrugPurchasedList();
    await getUserInfo(userId);
  }

  Future<void> getUserInfo(final int userId) async {
    isLoading.value = true;

    final Either<String, UserViewModel> result =
        await _repository.getUserWithId(userId);

    await result.fold(_getUserException, _getUserSuccessful);
  }

  Future<void> _getUserSuccessful(final UserViewModel user) async {
    isLoading.value = false;

    userDrugList.value = user.drugs;

    similarDrugList.value = userDrugList
        .where(
          (element) => element.pharmacyDrug.drug.id == drugId,
        )
        .toList();

    for (final UserDrugViewModel drugUser in similarDrugList) {
      final int index = pharmacyList.indexWhere(
        (element) => element.id == drugUser.pharmacyId,
      );

      numberOfDrugPurchasedList[index] = drugUser.count;
    }
  }

  Future<void> _getUserException(final String exception) async {}

  Future<void> onPressedAddToCartButton(
    final int itemIndex,
    final int number,
  ) async {
    final int index = userDrugList.indexWhere(
      (element) =>
          element.pharmacyId == pharmacyList[itemIndex].id &&
          element.pharmacyDrug.drug.id == drugId,
    );

    if (index >= 0) {
      if (number > 0) {
        userDrugList[index].count = number;
      } else {
        userDrugList.removeAt(index);
      }
    } else {
      userDrugList.add(
        UserDrugViewModel(
          pharmacyDrug: pharmacyList[itemIndex]
              .drugs
              .firstWhere((element) => element.drug.id == drugId),
          pharmacyId: pharmacyList[itemIndex].id,
          count: number,
        ),
      );
    }

    final Either<String, UserViewModel> result =
        await _repository.userDrugsUpdate(
      userId,
      UserDrugsUpdateDto(
        drugsUser: userDrugList,
      ),
    );

    result.fold(
      _userDrugsUpdateException,
      (final UserViewModel user) => _userDrugsUpdateSuccessful(
        itemIndex,
        number,
        user,
      ),
    );
  }

  Future<void> _userDrugsUpdateSuccessful(
    final int itemIndex,
    final int number,
    final UserViewModel user,
  ) async {
    numberOfDrugPurchasedList[itemIndex] = number;
    CustomScaffoldController.userProfile.value = UserProfileModel(
      id: user.id,
      firstName: user.firstName,
      mobile: user.mobile,
      base64Image: user.base64Image,
      drugs: user.drugs,
    );
  }

  Future<void> _userDrugsUpdateException(final String exception) async {}

  void _fillNumberOfDrugPurchasedList() {
    numberOfDrugPurchasedList.value = List.generate(
      pharmacyList.length,
      (index) => 0,
    );
  }

  Future<void> _getPharmacyList() async {
    isLoading.value = true;

    final Either<String, List<PharmacyViewModel>> result =
        await _repository.getPharmaciesInfo();

    await result.fold(_getPharmaciesFailed, _getPharmaciesSuccessful);
  }

  Future<void> _getPharmaciesFailed(final String exception) async {}

  Future<void> _getPharmaciesSuccessful(
      final List<PharmacyViewModel> pharmacies) async {
    isLoading.value = false;

    for (final PharmacyViewModel pharmacy in pharmacies) {
      for (final PharmacyDrugViewModel drugPharmacy in pharmacy.drugs) {
        if (drugPharmacy.drug.id == drugId && drugPharmacy.showPharmacyDrug) {
          pharmacyList.add(pharmacy);
        }
      }
    }
  }
}
