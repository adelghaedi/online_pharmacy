import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../shared/models/drug_view_model.dart';
import '../controllers/drugs_user_controller.dart';
import '../../../components/customScaffold/views/custom_scaffold.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../shared/circle_image.dart';

class DrugsUserPage extends GetView<DrugsUserController> {
  const DrugsUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            _scaffold(),
            if (controller.isLoading.value) utils.customProgressBar(),
          ],
        ));
  }

  Widget _scaffold() => CustomScaffold(
      body: _body(),
      wantDrawer: true,
      wantFloatActionButton: false,
      titleAppBar: LocaleKeys.home_page_drugs.tr);

  Widget _body() {
    if (controller.isLoading.value) {
      return const SizedBox.shrink();
    } else if (controller.drugList.isNotEmpty) {
      return _drugListView();
    } else {
      return _drugNotDefined();
    }
  }

  Widget _drugNotDefined() => Center(
        child: Text(
          LocaleKeys.drugs_page_not_available_drugs.tr,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      );

  Widget _drugListView() => ListView.builder(
        itemCount: controller.drugList.length,
        itemBuilder: (final BuildContext context, final int index) =>
            _itemDrugListView(
          controller.drugList[index],
        ),
      );

  Widget _itemDrugListView(final DrugViewModel drug) => GestureDetector(
        onTap: controller.onTapItemDrugListView,
        child: Container(
          decoration: utils.decorationContainer(),
          margin: const EdgeInsets.all(utils.scaffoldPadding),
          padding: const EdgeInsets.all(utils.scaffoldPadding),
          child: _itemRow(drug),
        ),
      );

  Widget _itemRow(final DrugViewModel drug) => Row(
        children: [
          _circleImage(drug.base64Image),
          utils.horizontalSpacer10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _drugName(drug.name),
                utils.verticalSpacer5,
                _drugManufacturingCompanyName(drug.manufacturingCompanyName),
              ],
            ),
          ),
        ],
      );

  Widget _drugManufacturingCompanyName(final String manufacturingCompanyName) =>
      Text(
        manufacturingCompanyName,
        style: const TextStyle(
          fontSize: 18,
        ),
      );

  Widget _drugName(final String name) => Text(
        name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );

  Widget _circleImage(final String? base64Image) => CircleImage(
        base64Image: base64Image,
        imageAssetsUrl: utils.drugImageUrl,
      );
}
