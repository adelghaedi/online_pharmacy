import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/circle_image.dart';
import '../controllers/drug_purchase_controller.dart';
import '../../../components/custom_scaffold/views/custom_scaffold.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../components/add_to_cart_button/add_to_cart_button.dart';
import '../../../../generated/locales.g.dart';

class DrugPurchasePage extends GetView<DrugPurchaseController> {
  const DrugPurchasePage({super.key});

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
        titleAppBar: LocaleKeys.buy_drug_page_buy_drug.tr,
      );

  Widget _body() {
    if (controller.isLoading.value) {
      return const SizedBox.shrink();
    } else if (controller.pharmacyDrugList.isNotEmpty) {
      return _drugListView();
    } else {
      return utils.noDefinedText(
        LocaleKeys.drugs_management_no_defined_drug_for_pharmacy.tr,
      );
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
      GestureDetector(
        onTap: () => controller.onTapItemDrugListView(index),
        child: Container(
          margin: const EdgeInsets.all(utils.scaffoldPadding),
          padding: const EdgeInsets.all(utils.scaffoldPadding),
          decoration: utils.decorationContainer(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _circleImage(controller.pharmacyDrugList[index].drug.base64Image),
              utils.horizontalSpacer10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    utils.titleContainer(
                        controller.pharmacyDrugList[index].drug.name),
                    utils.verticalSpacer5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: utils.subTitleContainer(
                              '${controller.pharmacyDrugList[index].price} ${LocaleKeys.buy_drug_page_toman.tr}'),
                        ),
                        _addToCartButton(index),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _circleImage(final String? base64Image) => CircleImage(
        base64Image: base64Image,
        imageAssetsUrl: utils.drugImageUrl,
      );

  Widget _addToCartButton(final int index) => Obx(
        () => AddToCartButton(
          number: controller.numberOfDrugPurchasedList[index],
          onPressedAddToCartButton: (final int number) =>
              controller.onPressedAddToCartButton(
            index,
            number,
          ),
        ),
      );
}
