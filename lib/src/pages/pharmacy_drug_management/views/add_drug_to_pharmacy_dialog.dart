import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/add_drug_to_pharmacy_controller.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class AddDrugToPharmacyDialog extends GetView<AddDrugToPharmacyController> {
  const AddDrugToPharmacyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        controller.isLoading.value
            ? const SizedBox.shrink()
            : _alertDialog(context),
        if (controller.isLoading.value) utils.customProgressBar(),
      ]),
    );
  }

  Widget _alertDialog(final BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(utils.scaffoldPadding),
        title: _titleSimpleDialog(),
        content:
            controller.drugList.isNotEmpty ? _form(context) : _noDefinedDrugs(),
      );

  Widget _noDefinedDrugs() => SizedBox(
        height: 200,
        child: Center(
          child: Text(
            LocaleKeys.drugs_page_not_available_drugs.tr,
          ),
        ),
      );

  Widget _form(final BuildContext context) => Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _drugsDropdownButtonFormField(),
              utils.verticalSpacer20,
              if (controller.valueDrugsDropDownButton.value != null)
                _priceTextFormField(),
              utils.verticalSpacer20,
              _submitButton(context),
            ],
          ),
        ),
      );

  Widget _priceTextFormField() => TextFormField(
        validator: controller.priceValidator,
        controller: controller.priceController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: LocaleKeys.add_drug_to_pharmacy_dialog_price.tr,
        ),
        onChanged: controller.onChangedPriceTextField,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
      );

  Widget _submitButton(final BuildContext context) => Obx(
        () => SizedBox(
          height: utils.elevatedButtonHeight,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.onPressedSubmit(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.reset_password_dialog_submit.tr),
                utils.horizontalSpacer10,
                if (controller.isSubmitInfo.value) _progressBar(),
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

  Widget _drugsDropdownButtonFormField() => DropdownButtonFormField<int>(
        validator: controller.drugsValidator,
        hint: Text(
          LocaleKeys.add_drug_to_pharmacy_dialog_select_drug.tr,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: controller.valueDrugsDropDownButton.value,
        items: controller.drugList
            .map(
              (element) => DropdownMenuItem(
                value: element.id,
                child: Text(element.name),
              ),
            )
            .toList(),
        onChanged: controller.onPressedDropDownButton,
      );

  Widget _titleSimpleDialog() => Text(
        LocaleKeys.drug_dialog_add_drug.tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );
}
