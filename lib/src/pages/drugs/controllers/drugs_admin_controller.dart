import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../repositories/drugs_repository.dart';
import '../../shared/models/drug_view_model.dart';
import '../controllers/add_drug_controller.dart';
import '../controllers/edit_drug_controller.dart';
import '../views/drug_dialog.dart';

class DrugsAdminController extends GetxController {
  final DrugsRepository _repository = DrugsRepository();

  final RxList<DrugViewModel> drugList = RxList();

  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _getDrugList();
  }

  Future<void> _getDrugList() async {
    isLoading.value = true;

    final Either<String, List<DrugViewModel>> result =
        await _repository.getDrugsInfo();

    result.fold(
      _getDrugListException,
      _getDrugListSuccessful,
    );
  }

  Future<void> _getDrugListException(final String exception) async {}

  Future<void> _getDrugListSuccessful(final List<DrugViewModel> drugs) async {
    isLoading.value = false;

    drugList.value = drugs;
  }

  Future<void> onPressedDeleteIcon(final int drugId) async {
    final Either<String, dynamic> result =
        await _repository.removeDrugWithId(drugId);

    result.fold(
      _removeDrugException,
      (final dynamic data) => _removeDrugSuccessful(drugId),
    );
  }

  Future<void> _removeDrugSuccessful(final int drugId) async {
    drugList.removeWhere(
      (element) => element.id == drugId,
    );
  }

  Future<void> _removeDrugException(final String exception) async {}

  Future<void> onPressedUpdateIcon(final DrugViewModel drug) async {
    Get.lazyPut(EditDrugController.new);
    final result = await Get.dialog(
      const DrugDialog<EditDrugController>(),
      arguments: drug.toJson(),
    );

    if (result != null) {
      final DrugViewModel drug = result as DrugViewModel;

      final int itemUpdatedIndex =
          drugList.indexWhere((element) => element.id == drug.id);
      drugList.removeAt(itemUpdatedIndex);
      drugList.insert(itemUpdatedIndex, result);
    }
  }

  Future<void> onPressedFloatActionButton() async {
    Get.lazyPut(AddDrugController.new);
    final result = await Get.dialog(
      const DrugDialog<AddDrugController>(),
    );

    if (result != null) {
      drugList.add(result as DrugViewModel);
    }
  }
}
