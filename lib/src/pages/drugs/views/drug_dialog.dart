import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/circle_image.dart';
import '../controllers/drug_base_controller.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class DrugDialog<T extends DrugBaseController> extends GetView<T> {
  const DrugDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return _alertDialog(context);
  }

  Widget _alertDialog(final BuildContext context) =>
      AlertDialog(
        title: _titleAlertDialog(),
        content: _form(context),
        contentPadding: const EdgeInsets.all(
          utils.scaffoldPadding,
        ),
      );

  Widget _titleAlertDialog() => Text(
        textAlign: TextAlign.center,
        controller.isAddDrugDialog
            ? LocaleKeys.drug_dialog_add_drug.tr
            : LocaleKeys.drug_dialog_edit_drug.tr,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

  Widget _form(final BuildContext context) => Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _circleImage(),
              utils.verticalSpacer20,
              _drugNameTextField(),
              utils.verticalSpacer20,
              _drugManufacturingCompanyNameTextField(),
              utils.verticalSpacer40,
              _button(context),
            ],
          ),
        ),
      );

  Widget _button(final BuildContext context) => Obx(
        () => SizedBox(
          height: utils.elevatedButtonHeight,
          child: ElevatedButton(
            onPressed: () => controller.onPressedButton(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.isAddDrugDialog
                      ? LocaleKeys.reset_password_dialog_submit.tr
                      : LocaleKeys.detail_pharmacy_page_edit.tr,
                ),
                if (controller.isLoading.value) _progressBar(),
              ],
            ),
          ),
        ),
      );

  Widget _progressBar() => const Padding(
        padding: EdgeInsets.all(5),
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );

  Widget _drugManufacturingCompanyNameTextField() => TextFormField(
        controller: controller.manufacturingCompanyNameController,
        validator: controller.drugManufacturingCompanyNameValidator,
        decoration: InputDecoration(
          labelText: LocaleKeys.drug_dialog_manufacturing_company_name.tr,
          hintText: utils.drugManufacturingCompanyNameHint,
        ),
      );

  Widget _drugNameTextField() => TextFormField(
        controller: controller.drugNameController,
        validator: controller.drugNameValidator,
        decoration: InputDecoration(
          labelText: LocaleKeys.user_page_first_name.tr,
          hintText: utils.drugNameHint,
        ),
      );

  Widget _circleImage() {
    return Obx(
      () => GestureDetector(
        onTap: controller.onTapCircleImage,
        child: CircleImage(
          imageAssetsUrl: utils.drugImageUrl,
          imageSize: 80,
          base64Image: controller.selectedImageUrl.value,
        ),
      ),
    );
  }
}
