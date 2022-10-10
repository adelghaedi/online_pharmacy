import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../repositories/drugs_repository.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../../generated/locales.g.dart';

abstract class DrugBaseController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final RxnString selectedImageUrl = RxnString();

  RxBool isLoading = false.obs;

  abstract bool isAddDrugDialog;

  final TextEditingController manufacturingCompanyNameController =TextEditingController();
  final TextEditingController drugNameController =TextEditingController();

  final DrugsRepository repository=DrugsRepository();

  void onTapCircleImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (selectedImage != null) {
      selectedImageUrl.value = utils.convertImageToBase64(selectedImage.path);
    }
  }

  String? drugNameValidator(final String? value) {
    if (value != null && value.trim().isNotEmpty) {
      return null;
    }
    return LocaleKeys.drug_dialog_drug_name_empty.tr;
  }

  String? drugManufacturingCompanyNameValidator(final String? value) {
    if (value != null && value.trim().isNotEmpty) {
      return null;
    }
    return LocaleKeys.drug_dialog_manufacturing_company_name_empty.tr;
  }

  Future<void> onPressedButton(final BuildContext context);
}
