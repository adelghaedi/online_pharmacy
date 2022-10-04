import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../shared/circle_image.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../controllers/pharmacy_base_controller.dart';
import '../../../components/customScaffold/views/custom_scaffold.dart';

class PharmacyPage<T extends PharmacyBaseController> extends GetView<T> {
  const PharmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        _scaffold(context),
        if (controller.isLoading.value) utils.customProgressBar(),
      ]),
    );
  }

  Widget _scaffold(BuildContext context) => CustomScaffold(
        body: _body(context),
        wantFloatActionButton: false,
        wantDrawer: true,
        titleAppBar: controller.isAddPharmacyPage
            ? LocaleKeys.pharmacy_page_add_pharmacy.tr
            : LocaleKeys.pharmacy_page_edit_pharmacy.tr,
      );

  Widget _body(BuildContext context) => Padding(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: _form(context),
      );

  Widget _form(BuildContext context) => Center(
        child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _circleImage(),
                  utils.verticalSpacer20,
                  _pharmacyNameTextField(),
                  utils.verticalSpacer20,
                  _addressTextField(),
                  utils.verticalSpacer20,
                  _doctorNameTextField(),
                  utils.verticalSpacer20,
                  _dateOfEstablishmentTextField(context),
                  utils.verticalSpacer40,
                  _button(context)
                ],
              ),
            )),
      );

  Widget _circleImage() {
    return Obx(
      () => GestureDetector(
        onTap: controller.onTapCircleImage,
        child: CircleImage(
          imageAssetsUrl: utils.pharmacyImageUrl,
          imageSize: 80,
          base64Image: controller.selectedImageUrl.value,
        ),
      ),
    );
  }

  Widget _button(final BuildContext context) => SizedBox(
        height: utils.elevatedButtonHeight,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => controller.onPressedButton(context),
          child: Text(
            controller.isAddPharmacyPage
                ? LocaleKeys.reset_password_dialog_submit.tr
                : LocaleKeys.detail_pharmacy_page_edit.tr,
          ),
        ),
      );

  Widget _dateOfEstablishmentTextField(final BuildContext context) =>
      TextFormField(
        onTap: () async {
          await controller.onTapDateOfEstablishmentTextField(context);
        },
        readOnly: true,
        controller: controller.dateOfEstablishmentController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: controller.dateOfEstablishmentValidator,
        decoration: InputDecoration(
          labelText: LocaleKeys.pharmacy_page_date_of_establishment.tr,
        ),
      );

  Widget _doctorNameTextField() => TextFormField(
        controller: controller.doctorNameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: controller.doctorNameValidator,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(
              '[a-zA-z]',
            ),
          )
        ],
        decoration: InputDecoration(
          labelText: LocaleKeys.pharmacy_page_doctor_name.tr,
        ),
      );

  Widget _addressTextField() => TextFormField(
        controller: controller.addressController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: controller.addressValidator,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(
              '[a-zA-z/]',
            ),
          )
        ],
        decoration: InputDecoration(
          labelText: LocaleKeys.pharmacy_page_address.tr,
        ),
      );

  Widget _pharmacyNameTextField() => TextFormField(
        controller: controller.pharmacyNameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: controller.pharmacyNameValidator,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(
              '[a-zA-z]',
            ),
          )
        ],
        decoration: InputDecoration(
          labelText: LocaleKeys.pharmacy_page_pharmacy_name.tr,
        ),
      );
}
