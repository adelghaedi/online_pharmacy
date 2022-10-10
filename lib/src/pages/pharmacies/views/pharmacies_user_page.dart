import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/models/pharmacy_view_model.dart';
import '../controllers/pharmacies_user_controller.dart';
import '../../../components/customScaffold/views/custom_scaffold.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../shared/circle_image.dart';
import '../../../../generated/locales.g.dart';

class PharmaciesUserPage extends GetView<PharmaciesUserController> {
  const PharmaciesUserPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        wantFloatActionButton: false,
        titleAppBar: LocaleKeys.home_page_pharmacies.tr,
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

  Widget _noDefinedPharmacy() => Center(
        child: Text(
          LocaleKeys.pharmacies_page_not_available_pharmacies.tr,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      );

  Widget _pharmacyListView() => ListView.builder(
        itemCount: controller.pharmacyList.length,
        itemBuilder: _itemPharmacyListView,
      );

  Widget _itemPharmacyListView(final BuildContext context, final int index) =>
      GestureDetector(
        onTap: controller.onTapItemPharmacyListView,
        child: Container(
          decoration: utils.decorationContainer(),
          margin: const EdgeInsets.all(utils.scaffoldPadding),
          padding: const EdgeInsets.all(utils.scaffoldPadding),
          child: _itemRow(
            controller.pharmacyList[index],
          ),
        ),
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
        ],
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
          fontSize: 22,
        ),
      );

  Widget _circleImage(final String? base64Image) => CircleImage(
        base64Image: base64Image,
        imageAssetsUrl: utils.pharmacyImageUrl,
      );
}
