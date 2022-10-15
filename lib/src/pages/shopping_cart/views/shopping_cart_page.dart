import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/add_to_cart_button/add_to_cart_button.dart';
import '../controllers/shopping_cart_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../../generated/locales.g.dart';
import '../../../components/custom_scaffold/views/custom_scaffold.dart';
import '../../../pages/shared/circle_image.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  const ShoppingCartPage({super.key});

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
        titleAppBar: LocaleKeys.home_page_shopping_cart.tr,
      );

  Widget _body() {
    if (controller.isLoading.value) {
      return const SizedBox.shrink();
    } else if (controller.userDrugList.isNotEmpty) {
      return _drugListView();
    } else {
      return utils.noDefinedText(
        LocaleKeys.shopping_cart_page_shopping_cart_empty.tr,
      );
    }
  }

  Widget _drugListView() => ListView.builder(
        itemCount: controller.userDrugList.length,
        itemBuilder: _itemDrugListView,
      );

  Widget _itemDrugListView(
    final BuildContext context,
    final int index,
  ) =>
      Container(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        margin: const EdgeInsets.all(utils.scaffoldPadding),
        decoration: utils.decorationContainer(),
        child: Row(
          children: [
            _circleImage(
              controller.userDrugList[index].pharmacyDrug.drug.base64Image,
            ),
            utils.horizontalSpacer10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  utils.titleContainer(
                      controller.userDrugList[index].pharmacyDrug.drug.name),
                  utils.verticalSpacer5,
                  utils.subTitleContainer(
                      '${controller.userDrugList[index].pharmacyDrug.price} ${LocaleKeys.buy_drug_page_toman.tr}'),
                  utils.verticalSpacer5,
                  utils.subTitleContainer(
                      '${LocaleKeys.home_page_pharmacy.tr}: ${controller.getPharmacyNameWithId(controller.userDrugList[index].pharmacyId)}'),
                ],
              ),
            ),
            _addToCartButton(index),
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
        imageAssetsUrl: utils.drugImageUrl,
        base64Image: base64Image,
      );
}
