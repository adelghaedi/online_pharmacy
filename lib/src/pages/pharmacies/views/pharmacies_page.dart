import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/pharmacy_view_model.dart';
import '../controllers/pharmacies_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../../generated/locales.g.dart';
import '../../shared/circle_image.dart';
import '../../../components/customScaffold/views/custom_scaffold.dart';
import '../../../components/customScaffold/controllers/custom_scaffold_controller.dart';

class PharmaciesPage extends GetView<PharmaciesController> {
  const PharmaciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(CustomScaffoldController.new);
    return Obx(
      () => Stack(children: [
        _scaffold(),
        if (controller.isLoading.value) utils.customProgressBar(),
      ]),
    );
  }

  Widget _scaffold() => CustomScaffold(
        body: _body(),
        wantDrawer: true,
        wantFloatActionButton: true,
        titleAppBar: LocaleKeys.home_admin_page_pharmacies.tr,
        onPressedFloatActionButton: controller.onPressedFloatingActionButton,
      );

  Widget _body() {
    if (controller.isLoading.value) {
      return const SizedBox.shrink();
    } else if (controller.pharmacyList.isNotEmpty) {
      return _pharmaciesListView();
    } else {
      return _pharmacyNotDefinedText();
    }
  }

  Widget _pharmaciesListView() => ListView.builder(
        itemCount: controller.pharmacyList.length,
        itemBuilder: (final BuildContext context, final int index) =>
            _itemListView(
          controller.pharmacyList[index],
        ),
      );

  Widget _pharmacyNotDefinedText() => Center(
        child: Text(
          LocaleKeys.pharmacies_page_not_available_pharmacies.tr,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      );

  Widget _itemListView(final PharmacyViewModel pharmacy) => GestureDetector(
        onTap: null,
        child: Container(
          decoration: utils.decorationContainer(),
          margin: const EdgeInsets.all(utils.scaffoldPadding),
          padding: const EdgeInsets.all(utils.scaffoldPadding),
          child: _itemRow(pharmacy),
        ),
      );

  Widget _itemRow(PharmacyViewModel pharmacy) => Row(
        children: [
          _circleImage(pharmacy),
          utils.horizontalSpacer10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _pharmacyName(pharmacy),
                utils.verticalSpacer5,
                _pharmacyDoctorName(pharmacy),
              ],
            ),
          ),
          utils.horizontalSpacer10,
          _iconsRow(pharmacy),
        ],
      );

  Widget _circleImage(PharmacyViewModel pharmacy) => CircleImage(
        base64Image: pharmacy.base64Image,
        imageAssetsUrl: utils.pharmacyImageUrl,
      );

  Widget _iconsRow(PharmacyViewModel pharmacy) => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailsIconButton(pharmacy),
            _deleteIconButton(pharmacy),
          ],
        ),
      );

  Widget _deleteIconButton(PharmacyViewModel pharmacy) => IconButton(
        onPressed: () => controller.onPressedDeleteIcon(pharmacy.id),
        icon: const Icon(Icons.delete),
      );

  Widget _detailsIconButton(PharmacyViewModel pharmacy) => IconButton(
        onPressed: () => controller.onPressedDetailIcon(pharmacy.toJson()),
        icon: const Icon(Icons.details),
      );

  Widget _pharmacyDoctorName(PharmacyViewModel pharmacy) => Text(
        pharmacy.doctorName,
        style: const TextStyle(
          fontSize: 18,
        ),
      );

  Widget _pharmacyName(PharmacyViewModel pharmacy) => Text(
        pharmacy.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
}
