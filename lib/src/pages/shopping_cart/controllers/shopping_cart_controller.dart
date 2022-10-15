import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../shared/models/user_drug_view_model.dart';
import '../../shared/models/pharmacy_view_model.dart';
import '../../shared/models/user_profile_model.dart';
import '../repositories/shopping_cart_repository.dart';
import '../../../components/custom_scaffold/controllers/custom_scaffold_controller.dart';
import '../../shared/models/user_view_model.dart';
import '../../shared/models/user_drugs_update_dto.dart';

class ShoppingCartController extends GetxController {
  final ShoppingCartRepository _repository = ShoppingCartRepository();

  final RxBool isLoading = false.obs;

  final RxList<UserDrugViewModel> userDrugList = RxList();

  final RxList<int> numberOfDrugPurchasedList = RxList();

  final RxList<PharmacyViewModel> pharmacyList = RxList();

  @override
  void onInit() async {
    super.onInit();
    await _getUserInfo(CustomScaffoldController.userProfile.value!.id);
  }

  void _fillNumberOfDrugPurchasedList() {
    numberOfDrugPurchasedList.value = List.generate(
      userDrugList.length,
      (index) => 0,
    );
  }

  Future<void> _getUserInfo(final int id) async {
    isLoading.value = true;

    final Either<String, UserViewModel> result =
        await _repository.getUserWithId(id);

    await result.fold(
      _getUserException,
      _getUserSuccessful,
    );
  }

  Future<void> _getUserSuccessful(final UserViewModel user) async {
    userDrugList.value = user.drugs;

    final Either<String, List<PharmacyViewModel>> result =
        await _repository.getPharmaciesInfo();

    await result.fold(
      _getPharmaciesException,
      _getPharmaciesSuccessful,
    );

    isLoading.value = false;

    _fillNumberOfDrugPurchasedList();

    for (int i = 0; i < userDrugList.length; i++) {
      numberOfDrugPurchasedList[i] = userDrugList[i].count;
    }
  }

  Future<void> _getPharmaciesSuccessful(
    final List<PharmacyViewModel> pharmacies,
  ) async {
    pharmacyList.value = pharmacies;
  }

  Future<void> _getPharmaciesException(final String exception) async {}

  Future<void> _getUserException(final String exception) async {}

  Future<void> onPressedAddToCartButton(
    final int itemIndex,
    final int number,
  ) async {
    if (number > 0) {
      userDrugList[itemIndex].count = number;
    } else {
      userDrugList.removeAt(itemIndex);
      numberOfDrugPurchasedList.removeAt(itemIndex);
    }

    final Either<String, UserViewModel> result =
        await _repository.userDrugsUpdate(
      CustomScaffoldController.userProfile.value!.id,
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
    if (number > 0) {
      numberOfDrugPurchasedList[itemIndex] = number;
    }
    CustomScaffoldController.userProfile.value = UserProfileModel(
      id: user.id,
      firstName: user.firstName,
      mobile: user.mobile,
      base64Image: user.base64Image,
      drugs: user.drugs,
    );
  }

  Future<void> _userDrugsUpdateException(final String exception) async {}

  String getPharmacyNameWithId(final int id) {
    return pharmacyList
        .firstWhere(
          (element) => element.id == id,
        )
        .name;
  }
}
