import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../components/custom_scaffold/controllers/custom_scaffold_controller.dart';
import '../../shared/models/user_drug_view_model.dart';
import '../../shared/models/user_profile_model.dart';
import '../../shared/models/user_view_model.dart';
import '../repositories/drug_purchase_repository.dart';
import '../../shared/models/pharmacy_drug_view_model.dart';
import '../../shared/models/user_drugs_update_dto.dart';

class DrugPurchaseDetailsController extends GetxController {
  final DrugPurchaseRepository _repository = DrugPurchaseRepository();

  final int userId = Get.arguments[0];

  final int pharmacyId = Get.arguments[1];

  final PharmacyDrugViewModel drugOfPharmacy = PharmacyDrugViewModel.fromJson(
    Get.arguments[2],
  );

  final List<UserDrugViewModel> userDrugList = Get.arguments[3];

  RxInt numberOfDrugPurchased = RxInt(0);

  @override
  void onInit() {
    super.onInit();

    final int index = _checkThisDrugOfPharmacyExistsInUserDrugList();

    if (index >= 0) {
      numberOfDrugPurchased.value = userDrugList[index].count;
    }
  }

  int _checkThisDrugOfPharmacyExistsInUserDrugList() {
    return userDrugList.indexWhere(
      (element) =>
          element.pharmacyId == pharmacyId &&
          element.pharmacyDrug.drug.id == drugOfPharmacy.drug.id,
    );
  }

  void onPressedAddToCartButton(final int number) async {
    final int index = _checkThisDrugOfPharmacyExistsInUserDrugList();

    if (index >= 0) {
      if (number > 0) {
        userDrugList[index].count = number;
      } else {
        userDrugList.removeAt(index);
      }
    } else {
      UserDrugViewModel drugUser = UserDrugViewModel(
        pharmacyDrug: drugOfPharmacy,
        pharmacyId: pharmacyId,
        count: number,
      );

      userDrugList.add(drugUser);
    }

    Either<String, UserViewModel> result = await _repository.userDrugsUpdate(
      userId,
      UserDrugsUpdateDto(
        drugsUser: userDrugList,
      ),
    );

    await result.fold(
      _userDrugsUpdateException,
      (final UserViewModel user) => _userDrugsUpdateSuccessful(number, user),
    );
  }

  Future<void> _userDrugsUpdateSuccessful(
    final int number,
    final UserViewModel user,
  ) async {
    numberOfDrugPurchased.value = number;
    CustomScaffoldController.userProfile.value = UserProfileModel(
      id: user.id,
      firstName: user.firstName,
      mobile: user.mobile,
      base64Image: user.base64Image,
      drugs: user.drugs,
    );
  }

  Future<void> _userDrugsUpdateException(final String exception) async {}
}
