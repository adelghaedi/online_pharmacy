import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/search/simple_search.dart';
import '../../../shared/models/pharmacy_view_model.dart';
import '../controllers/pharmacies_user_controller.dart';
import '../../../../components/custom_scaffold/views/custom_scaffold.dart';
import '../../../../infrastructure/utils/utils.dart' as utils;
import '../../../shared/circle_image.dart';
import '../../../../../generated/locales.g.dart';

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
        wantFloatingActionButton: false,
        titleAppBar: LocaleKeys.home_page_pharmacies.tr,
      );

  Widget _body() {
    if (controller.isLoading.value) {
      return const SizedBox.shrink();
    } else if (controller.pharmacyList.isNotEmpty) {
      return _pharmacyListView();
    } else {
      return utils.noDefinedText(
          LocaleKeys.pharmacies_page_not_available_pharmacies.tr);
    }
  }

  Widget _pharmacyListView() => Padding(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: Column(children: [
          _search(),
          utils.verticalSpacer20,
          Expanded(
            child: ListView.builder(
              itemCount: controller.pharmacyList.length,
              itemBuilder: _itemPharmacyListView,
            ),
          ),
        ]),
      );

  Widget _search() => SimpleSearch(
        onPressedSearchIcon: controller.onPressedSearchIcon,
        onPressedFilterButton: controller.onPressedFilterButton,
      );

  Widget _itemPharmacyListView(final BuildContext context, final int index) =>
      GestureDetector(
        onTap: () => controller.onTapItemPharmacyListView(index),
        child: Container(
          decoration: utils.decorationContainer(),
          padding: const EdgeInsets.all(utils.scaffoldPadding),
          margin: const EdgeInsets.only(bottom: utils.scaffoldPadding),
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
                utils.titleContainer(pharmacy.name),
                utils.verticalSpacer5,
                utils.subTitleContainer(pharmacy.doctorName),
              ],
            ),
          ),
        ],
      );

  Widget _circleImage(final String? base64Image) => CircleImage(
        base64Image: base64Image,
        imageAssetsUrl: utils.pharmacyImageUrl,
      );
}
