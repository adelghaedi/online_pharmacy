import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/models/pharmacy_view_model.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../../generated/locales.g.dart';
import '../../shared/circle_image.dart';
import '../../../components/customScaffold/views/custom_scaffold.dart';
import '../../../components/customScaffold/controllers/custom_scaffold_controller.dart';
import '../controllers/pharmacies_admin_controller.dart';

class PharmaciesAdminPage extends GetView<PharmaciesAdminController> {
  const PharmaciesAdminPage({super.key});

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
        titleAppBar: LocaleKeys.home_page_pharmacies.tr,
        onPressedFloatActionButton: controller.onPressedFloatingActionButton,
      );

  Widget _body() {
    if (controller.isLoading.value) {
      return const SizedBox.shrink();
    } else if (controller.pharmacyList.isNotEmpty) {
      return _pharmacyListView();
    } else {
      return _noDefinedPharmacy();
    }
  }

  Widget _pharmacyListView() => ListView.builder(
        itemCount: controller.pharmacyList.length,
        itemBuilder: (final BuildContext context, final int index) =>
            _itemPharmacyListView(
          controller.pharmacyList[index],
        ),
      );

  Widget _noDefinedPharmacy() => Center(
        child: Text(
          LocaleKeys.pharmacies_page_not_available_pharmacies.tr,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      );

  Widget _itemPharmacyListView(final PharmacyViewModel pharmacy) => Container(
        decoration: utils.decorationContainer(),
        margin: const EdgeInsets.all(utils.scaffoldPadding),
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: _itemRow(pharmacy),
      );

  Widget _itemRow(final PharmacyViewModel pharmacy) => Row(
        children: [
          _circleImage(pharmacy.base64Image),
          utils.horizontalSpacer10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _pharmacyName(pharmacy.name),
                utils.verticalSpacer5,
                _pharmacyDoctorName(pharmacy.doctorName),
              ],
            ),
          ),
          utils.horizontalSpacer10,
          _iconsColumn(pharmacy),
        ],
      );

  Widget _iconsColumn(final PharmacyViewModel pharmacy) => Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _detailsIconButton(pharmacy),
              _deleteIconButton(pharmacy),
            ],
          ),
          OutlinedButton(
            onPressed: () =>
                controller.onPressedDrugsManagement(pharmacy.toJson()),
            child: Text(
              LocaleKeys.drugs_management_drugs_management.tr,
            ),
          ),
        ]),
      );

  Widget _circleImage(final String? base64Image) => CircleImage(
        base64Image: base64Image,
        imageAssetsUrl: utils.pharmacyImageUrl,
      );

  Widget _deleteIconButton(PharmacyViewModel pharmacy) => IconButton(
        onPressed: () => controller.onPressedDeleteIcon(pharmacy.id),
        icon: const Icon(Icons.delete),
      );

  Widget _detailsIconButton(PharmacyViewModel pharmacy) => IconButton(
        onPressed: () => controller.onPressedDetailIcon(pharmacy.toJson()),
        icon: const Icon(Icons.details),
      );

  Widget _pharmacyDoctorName(final String doctorName) => Text(
        doctorName,
        style: const TextStyle(
          fontSize: 18,
        ),
      );

  Widget _pharmacyName(final String name) => Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
}
