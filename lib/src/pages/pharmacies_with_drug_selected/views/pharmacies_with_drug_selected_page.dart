import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pharmacies_with_drug_selected_controller.dart';
import '../../../components/add_to_cart_button/add_to_cart_button.dart';
import '../../../components/custom_scaffold/views/custom_scaffold.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../../generated/locales.g.dart';
import '../../shared/circle_image.dart';

class PharmaciesWithDrugSelectedPage
    extends GetView<PharmaciesWithDrugSelectedController> {
  const PharmaciesWithDrugSelectedPage({super.key});

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
        titleAppBar: LocaleKeys
            .pharmacies_with_drug_selected_page_pharmacies_with_selected_drugs
            .tr,
      );

  Widget _body() {
    if (controller.isLoading.value) {
      return const SizedBox.shrink();
    } else if (controller.pharmacyList.isNotEmpty) {
      return _pharmacyListView();
    } else {
      return utils.noDefinedText(LocaleKeys
          .pharmacies_with_drug_selected_page_no_pharmacy_has_selected_drug.tr);
    }
  }

  Widget _pharmacyListView() => ListView.builder(
        itemCount: controller.pharmacyList.length,
        itemBuilder: _pharmacyItemListView,
      );

  Widget _pharmacyItemListView(final BuildContext context, final int index) =>
      Container(
        margin: const EdgeInsets.all(utils.scaffoldPadding),
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        decoration: utils.decorationContainer(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _circleImage(controller.pharmacyList[index].base64Image),
            utils.horizontalSpacer10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  utils.titleContainer(controller.pharmacyList[index].name),
                  utils.verticalSpacer5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: utils.subTitleContainer(
                            '${controller.pharmacyList[index].drugs.firstWhere((element) => element.drug.id == controller.drugId).price} ${LocaleKeys.buy_drug_page_toman.tr}'),
                      ),
                      _addToCartButton(index),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
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

  Widget _circleImage(final String? base64Image) => CircleImage(
        base64Image: base64Image,
        imageAssetsUrl: utils.pharmacyImageUrl,
      );
}
