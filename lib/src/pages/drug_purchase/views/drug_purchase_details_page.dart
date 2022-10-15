import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/add_to_cart_button/add_to_cart_button.dart';
import '../controllers/drug_purchase_details_controller.dart';
import '../../../components/custom_scaffold/views/custom_scaffold.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../shared/circle_image.dart';

class DrugPurchaseDetailsPage extends GetView<DrugPurchaseDetailsController> {
  const DrugPurchaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() => CustomScaffold(
        body: _body(),
        wantDrawer: true,
        wantFloatingActionButton: false,
        titleAppBar: LocaleKeys.detail_buy_drug_page_detail_buy_drug.tr,
      );

  Widget _body() => ListView(
        padding: const EdgeInsets.all(
          utils.scaffoldPadding,
        ),
        children: [
          _circleImage(),
          utils.verticalSpacer20,
          _drugNameListTile(),
          utils.verticalSpacer20,
          _drugManufacturingCompanyNameListTile(),
          utils.verticalSpacer20,
          _drugPriceListTile(),
          utils.verticalSpacer40,
          _addToCartButton(),
        ],
      );

  Widget _drugPriceListTile() => ListTile(
        title: utils
            .titleListTile(LocaleKeys.add_drug_to_pharmacy_dialog_price.tr),
        subtitle:
            utils.subTitleListTile('${controller.drugOfPharmacy.price} تومان'),
      );

  Widget _drugManufacturingCompanyNameListTile() => ListTile(
        title: utils.titleListTile(
            LocaleKeys.drug_dialog_manufacturing_company_name.tr),
        subtitle: utils.subTitleListTile(
            controller.drugOfPharmacy.drug.manufacturingCompanyName),
      );

  Widget _circleImage() => CircleImage(
        base64Image: controller.drugOfPharmacy.drug.base64Image,
        imageAssetsUrl: utils.drugImageUrl,
        imageSize: 80,
      );

  Widget _drugNameListTile() => ListTile(
        title: utils.titleListTile(LocaleKeys.user_page_first_name.tr),
        subtitle: utils.subTitleListTile(controller.drugOfPharmacy.drug.name),
      );

  Widget _addToCartButton() => Obx(
        () => SizedBox(
          height: utils.buttonHeight,
          width: double.infinity,
          child: AddToCartButton(
            number: controller.numberOfDrugPurchased.value,
            onPressedAddToCartButton: controller.onPressedAddToCartButton,
          ),
        ),
      );
}
