import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/drugs_admin_controller.dart';
import '../../../components/customScaffold/views/custom_scaffold.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../shared/circle_image.dart';
import '../../shared/models/drug_view_model.dart';

class DrugsAdminPage extends GetView<DrugsAdminController> {
  const DrugsAdminPage({super.key});

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
        wantFloatActionButton: true,
        titleAppBar: LocaleKeys.home_page_drugs.tr,
        onPressedFloatActionButton: controller.onPressedFloatActionButton,
      );

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

  Widget _itemDrugListView(final DrugViewModel drug) => Container(
        decoration: utils.decorationContainer(),
        margin: const EdgeInsets.all(utils.scaffoldPadding),
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: _itemRow(drug),
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
          _updateIconButton(drug),
          _deleteIconButton(drug.id),
        ],
      );

  Widget _updateIconButton(final DrugViewModel drug) => IconButton(
        onPressed: () => controller.onPressedUpdateIcon(drug),
        icon: const Icon(
          Icons.edit,
        ),
      );

  Widget _deleteIconButton(final int drugId) => IconButton(
        onPressed: () => controller.onPressedDeleteIcon(drugId),
        icon: const Icon(Icons.delete),
      );

  Widget _circleImage(final String? base64ImageDrug) => CircleImage(
        imageAssetsUrl: utils.drugImageUrl,
        base64Image: base64ImageDrug,
      );

  Widget _drugName(final String drugName) => Text(
        drugName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );

  Widget _drugManufacturingCompanyName(
          final String drugManufacturingCompanyName) =>
      Text(
        drugManufacturingCompanyName,
        style: const TextStyle(
          fontSize: 18,
        ),
      );
}
