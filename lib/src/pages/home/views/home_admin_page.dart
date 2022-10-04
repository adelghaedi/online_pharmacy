import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/customScaffold/views/custom_scaffold.dart';
import '../../../../generated/locales.g.dart';
import '../controllers/home_admin_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class HomeAdminPage extends GetView<HomeAdminController> {
  const HomeAdminPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() => CustomScaffold(
        body: _body(),
        wantDrawer: true,
        wantFloatActionButton: false,
        titleAppBar: LocaleKeys.home_page_pharmacy.tr,
        isHomeAdminPage: true,
      );

  Widget _body() => GridView.count(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        crossAxisCount: 2,
        crossAxisSpacing: utils.scaffoldPadding,
        mainAxisSpacing: utils.scaffoldPadding,
        children: [
          _itemGridView(
            LocaleKeys.home_admin_page_pharmacies.tr,
            controller.onTapPharmaciesItem,
          ),
          _itemGridView(
            LocaleKeys.home_admin_page_drugs.tr,
            controller.onTapDrugsItem,
          ),
          _itemGridView(
            LocaleKeys.profile_page_profile.tr,
            controller.onTapProfileItem,
          ),
        ],
      );

  Widget _itemGridView(
    final String title,
    final VoidCallback? onTap,
  ) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: utils.decorationContainer(),
          child: Center(
            child: Text(
              title,
              style: _textStyle(),
            ),
          ),
        ),
      );

  TextStyle _textStyle() => const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      );
}
