import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pharmacy_drug_management_controller.dart';
import '../../../components/custom_scaffold/views/custom_scaffold.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../shared/circle_image.dart';
import '../../../../generated/locales.g.dart';

class PharmacyDrugManagementPage
    extends GetView<PharmacyDrugsManagementController> {
  const PharmacyDrugManagementPage({super.key});

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
        wantFloatingActionButton: true,
        titleAppBar: LocaleKeys.drugs_management_drugs_management.tr,
        onPressedFloatingActionButton: controller.onPressedFloatActionButton,
      );

  Widget _body() {
    if (controller.isLoading.value) {
      return const SizedBox.shrink();
    } else if (controller.pharmacyDrugList.isNotEmpty) {
      return _drugListView();
    } else {
      return utils.noDefinedText(
          LocaleKeys.drugs_management_no_defined_drug_for_pharmacy.tr);
    }
  }

  Widget _drugListView() => ListView.builder(
        itemCount: controller.pharmacyDrugList.length,
        itemBuilder: _itemDrugListView,
      );

  Widget _itemDrugListView(
    final BuildContext context,
    final int index,
  ) =>
      Container(
        margin: const EdgeInsets.all(utils.scaffoldPadding),
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        decoration: utils.decorationContainer(),
        child: Row(
          children: [
            _circleImage(controller.pharmacyDrugList[index].drug.base64Image),
            utils.horizontalSpacer10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _drugName(controller.pharmacyDrugList[index].drug.name),
                utils.verticalSpacer5,
                _drugPrice(controller.pharmacyDrugList[index].price),
              ],
            ),
            utils.horizontalSpacer10,
            _showDrugSwitchRow(index),
          ],
        ),
      );

  Widget _showDrugSwitchRow(final int index) => Expanded(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Text(
              LocaleKeys.drugs_management_show_drug.tr,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Obx(
            () => Switch(
              value: controller.showDrugSwitchesValue[index],
              onChanged: (final bool value) =>
                  controller.onChangedShowDrugSwitch(
                value,
                index,
              ),
            ),
          ),
        ]),
      );

  Widget _drugPrice(final String price) => Text(
        '$price ${LocaleKeys.buy_drug_page_toman.tr}',
        style: const TextStyle(
          fontSize: 18,
        ),
      );

  Widget _drugName(final String name) => Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );

  Widget _circleImage(final String? base64Image) => CircleImage(
        imageAssetsUrl: utils.drugImageUrl,
        base64Image: base64Image,
      );
}
