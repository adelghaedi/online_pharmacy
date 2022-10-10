import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/utils/utils.dart' as utils;
import '../controllers/custom_scaffold_controller.dart';
import '../../../pages/shared/circle_image.dart';
import '../../../../generated/locales.g.dart';

class CustomScaffold extends GetView<CustomScaffoldController> {
  final Widget body;
  final bool wantDrawer;
  final bool wantFloatActionButton;
  final String titleAppBar;
  final VoidCallback? onPressedFloatActionButton;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final bool isHomeUserPage;
  final bool isLoginPage;

  CustomScaffold({
    super.key,
    required this.body,
    required this.wantDrawer,
    required this.wantFloatActionButton,
    required this.titleAppBar,
    this.onPressedFloatActionButton,
    this.isHomeUserPage = false,
    this.isLoginPage = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(CustomScaffoldController.new);
    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(),
      body: body,
      endDrawer: _drawer(),
      floatingActionButton: _floatActionButton(),
    );
  }

  Widget? _floatActionButton() => wantFloatActionButton
      ? FloatingActionButton(
          onPressed: onPressedFloatActionButton,
          child: const Icon(Icons.add),
        )
      : null;

  AppBar _appBar() => AppBar(
        leading: _backIcon(),
        title: Text(titleAppBar),
        actions: [
          _drawerIcon(),
        ],
      );

  Widget _backIcon() => GestureDetector(
        onTap: () => controller.onTapBackIcon(isHomeUserPage, isLoginPage),
        child: const Icon(
          Icons.chevron_left,
        ),
      );

  Widget? _drawer() => wantDrawer
      ? Obx(
          () => Drawer(
            width: 250,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(utils.scaffoldPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _userInfoRow(),
                    utils.drawerDivider(),
                    _pharmaciesTextButton(),
                    _drugsTextButton(),
                    _profileTextButton(),
                    _changePasswordTextButton(),
                    Expanded(child: _exitTextButton())
                  ],
                ),
              ),
            ),
          ),
        )
      : null;

  Widget _userInfoRow() => Row(
        children: [
          _circleImage(),
          utils.horizontalSpacer10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _firstName(),
                utils.verticalSpacer5,
                _mobile(),
              ],
            ),
          ),
        ],
      );

  Widget _mobile() => Text(
        CustomScaffoldController.userProfile.value?.mobile ?? '',
        style: const TextStyle(fontSize: 16),
      );

  Widget _firstName() => Text(
        CustomScaffoldController.userProfile.value?.firstName ?? '',
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _drawerIcon() => wantDrawer
      ? IconButton(
          onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
          icon: const Icon(Icons.menu),
        )
      : const SizedBox.shrink();

  Widget _exitTextButton() => Align(
        alignment: AlignmentDirectional.bottomStart,
        child: TextButton(
          onPressed: controller.onPressedExit,
          child: Text(
            LocaleKeys.drawer_exit.tr,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );

  Widget _changePasswordTextButton() => TextButton(
        onPressed: controller.onPressedChangePassword,
        child: Text(
          LocaleKeys.forgot_password_page_change_password.tr,
          style: const TextStyle(fontSize: 20),
        ),
      );

  Widget _profileTextButton() => TextButton(
        onPressed: controller.onPressedProfile,
        child: Text(
          LocaleKeys.profile_page_profile.tr,
          style: const TextStyle(fontSize: 20),
        ),
      );

  Widget _drugsTextButton() => TextButton(
        onPressed: controller.onPressedDrugs,
        child: Text(
          LocaleKeys.home_page_drugs.tr,
          style: const TextStyle(fontSize: 20),
        ),
      );

  TextButton _pharmaciesTextButton() => TextButton(
        onPressed: controller.onPressedPharmacies,
        child: Text(
          LocaleKeys.home_page_pharmacies.tr,
          style: const TextStyle(fontSize: 20),
        ),
      );

  Widget _circleImage() => CircleImage(
        base64Image: CustomScaffoldController.userProfile.value?.base64Image,
      );
}
