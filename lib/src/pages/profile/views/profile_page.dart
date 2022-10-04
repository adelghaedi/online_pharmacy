import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/profile_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../components/customScaffold/views/custom_scaffold.dart';
import '../../shared/circle_image.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        _scaffold(),
        if (controller.adminInfo.value == null) utils.customProgressBar(),
      ]),
    );
  }

  Widget _scaffold() => CustomScaffold(
        body: _body(),
        wantDrawer: true,
        wantFloatActionButton: false,
        titleAppBar: LocaleKeys.profile_page_profile.tr,
      );

  Widget _body() => Padding(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _circleImage(),
              utils.verticalSpacer20,
              _firstNameListTile(),
              utils.verticalSpacer20,
              _lastNameListTile(),
              utils.verticalSpacer20,
              _mobileListTile(),
              utils.verticalSpacer20,
              _birthDateListTile(),
              utils.verticalSpacer20,
              _userNameListTile(),
              utils.verticalSpacer40,
              utils.editInfoButton(controller.onPressedEditInfo),
            ],
          ),
        ),
      );

  Widget _circleImage() => CircleImage(
        imageAssetsUrl: utils.personImageUrl,
        imageSize: 80,
        base64Image: controller.adminInfo.value?.base64Image ?? '',
      );

  Widget _userNameListTile() => ListTile(
        title: utils.titleListTile(LocaleKeys.login_page_username.tr),
        subtitle:
            utils.subTitleListTile(controller.adminInfo.value?.userName ?? ''),
      );

  Widget _birthDateListTile() => ListTile(
        title: utils.titleListTile(LocaleKeys.user_page_birth_date.tr),
        subtitle:
            utils.subTitleListTile(controller.adminInfo.value?.birthDate ?? ''),
      );

  Widget _mobileListTile() => ListTile(
        title: utils.titleListTile(LocaleKeys.user_page_mobile.tr),
        subtitle:
            utils.subTitleListTile(controller.adminInfo.value?.mobile ?? ''),
      );

  Widget _lastNameListTile() => ListTile(
        title: utils.titleListTile(LocaleKeys.user_page_last_name.tr),
        subtitle:
            utils.subTitleListTile(controller.adminInfo.value?.lastName ?? ''),
      );

  Widget _firstNameListTile() => ListTile(
        title: utils.titleListTile(LocaleKeys.user_page_first_name.tr),
        subtitle:
            utils.subTitleListTile(controller.adminInfo.value?.firstName ?? ''),
      );
}
