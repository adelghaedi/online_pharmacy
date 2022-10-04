import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/detail_pharmacy_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../shared/circle_image.dart';
import '../../../components/customScaffold/views/custom_scaffold.dart';

class DetailPharmacyPage extends GetView<DetailPharmacyController> {
  const DetailPharmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() =>CustomScaffold(
    body: _body(),
    wantDrawer: true,
    wantFloatActionButton: false,
    titleAppBar: LocaleKeys.detail_pharmacy_page_pharmacy_profile.tr,
  );


  Widget _body() => Padding(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _circleImage(),
              utils.verticalSpacer20,
              _nameListTile(),
              utils.verticalSpacer20,
              _addressListTile(),
              utils.verticalSpacer20,
              _doctorNameListTile(),
              utils.verticalSpacer20,
              _dateOfEstablishmentListTile(),
              utils.verticalSpacer40,
              utils.editInfoButton(controller.onPressedEditInfo),
            ],
          ),
        ),
      );

  Widget _circleImage() => CircleImage(
        imageAssetsUrl: utils.pharmacyImageUrl,
        base64Image: controller.pharmacyInfo['base64Image'],
        imageSize: 80,
      );

  Widget _dateOfEstablishmentListTile() => ListTile(
        title: utils
            .titleListTile(LocaleKeys.pharmacy_page_date_of_establishment.tr),
        subtitle: utils.subTitleListTile(
          controller.pharmacyInfo['dateOfEstablishment'],
        ),
      );

  Widget _doctorNameListTile() => ListTile(
        title: utils.titleListTile(LocaleKeys.pharmacy_page_doctor_name.tr),
        subtitle: utils.subTitleListTile(
          controller.pharmacyInfo['doctorName'],
        ),
      );

  Widget _addressListTile() => ListTile(
        title: utils.titleListTile(LocaleKeys.pharmacy_page_address.tr),
        subtitle: utils.subTitleListTile(
          controller.pharmacyInfo['address'],
        ),
      );

  Widget _nameListTile() => ListTile(
        title: utils.titleListTile(LocaleKeys.pharmacy_page_pharmacy_name.tr),
        subtitle: utils.subTitleListTile(
          controller.pharmacyInfo['name'],
        ),
      );
}
