import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../../shared/models/pharmacy_drug_view_model.dart';
import '../../shared/models/user_profile_model.dart';
import '../repositories/drug_purchase_repository.dart';
import '../../shared/models/user_drug_view_model.dart';
import '../../../components/custom_scaffold/controllers/custom_scaffold_controller.dart';
import '../../shared/models/user_view_model.dart';
import '../../shared/models/user_drugs_update_dto.dart';

class DrugPurchaseController extends GetxController {
  final int pharmacyId = Get.arguments['id'];

  final int userId = CustomScaffoldController.userProfile.value!.id;

  final DrugPurchaseRepository _repository = DrugPurchaseRepository();

  RxList<PharmacyDrugViewModel> pharmacyDrugList = RxList();

  RxList<UserDrugViewModel> userDrugList = RxList();

  RxList<UserDrugViewModel> userOfDrugsInThisPharmacy = RxList();

  RxList<int> numberOfDrugPurchasedList = RxList();

  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    pharmacyDrugList.value = _getPharmacyDrugList();
    _fillNumberOfDrugPurchasedList();
    await getUserInfo(CustomScaffoldController.userProfile.value!.id);
  }

  List<PharmacyDrugViewModel> _getPharmacyDrugList() {
    return ((Get.arguments['drugs'] as List)
            .map(
              (json) => PharmacyDrugViewModel.fromJson(json),
            )
            .toList())
        .where(
          (element) => element.showPharmacyDrug == true,
        )
        .toList();
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

    userOfDrugsInThisPharmacy.value = user.drugs
        .where(
          (element) => element.pharmacyId == pharmacyId,
        )
        .toList();

    for (final UserDrugViewModel drugUser in userOfDrugsInThisPharmacy) {
      final int index = pharmacyDrugList.indexWhere(
        (element) => element.drug.id == drugUser.pharmacyDrug.drug.id,
      );

      numberOfDrugPurchasedList[index] = drugUser.count;
    }
  }

  Future<void> _getUserException(final String exception) async {}

  void _fillNumberOfDrugPurchasedList() {
    numberOfDrugPurchasedList.value = List.generate(
      pharmacyDrugList.length,
      (index) => 0,
    );
  }

  void onPressedAddToCartButton(
    final int itemIndex,
    final int number,
  ) async {
    final int index = userDrugList.indexWhere(
      (element) =>
          element.pharmacyId == pharmacyId &&
          element.pharmacyDrug.drug.id == pharmacyDrugList[itemIndex].drug.id,
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
          pharmacyDrug: pharmacyDrugList[itemIndex],
          pharmacyId: pharmacyId,
          count: number,
        ),
      );
    }

    final Either<String, UserViewModel> result =
        await _repository.userDrugsUpdate(
      userId,
      UserDrugsUpdateDto(drugsUser: userDrugList),
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
    final int index,
    final int number,
    final UserViewModel user,
  ) async {
    numberOfDrugPurchasedList[index] = number;
    CustomScaffoldController.userProfile.value = UserProfileModel(
      id: user.id,
      firstName: user.firstName,
      mobile: user.mobile,
      base64Image: user.base64Image,
      drugs: user.drugs,
    );
  }

  Future<void> _userDrugsUpdateException(final String exception) async {}

  void onTapItemDrugListView(final int index) async {
    final result = await Get.toNamed(
        PharmacyModuleRoutes.drugPurchaseDetailsPage,
        arguments: [
          userId,
          pharmacyId,
          pharmacyDrugList[index].toJson(),
          userDrugList,
        ]);

    if (result == null) {
      onInit();
    }
  }
}
