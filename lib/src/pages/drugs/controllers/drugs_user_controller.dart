import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../shared/models/drug_view_model.dart';
import '../repositories/drugs_repository.dart';

class DrugsUserController extends GetxController {
  final RxBool isLoading = false.obs;

  final RxList<DrugViewModel> drugList = RxList();

  final DrugsRepository _repository = DrugsRepository();

  @override
  void onInit() {
    super.onInit();
    _getDrugList();
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

  void onTapItemDrugListView() {}
}
