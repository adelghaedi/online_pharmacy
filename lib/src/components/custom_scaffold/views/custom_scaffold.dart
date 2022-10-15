import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/utils/utils.dart' as utils;
import '../controllers/custom_scaffold_controller.dart';
import '../../../pages/shared/circle_image.dart';
import '../../../../generated/locales.g.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final bool wantDrawer;
  final bool wantFloatingActionButton;
  final String titleAppBar;
  final VoidCallback? onPressedFloatingActionButton;
  final bool isLoginPage;
  final bool isHomePage;
  late CustomScaffoldController controller;

  CustomScaffold({
    super.key,
    required this.body,
    required this.wantDrawer,
    required this.wantFloatingActionButton,
    required this.titleAppBar,
    this.onPressedFloatingActionButton,
    this.isLoginPage = false,
    this.isHomePage = false,
  }) {
    controller = CustomScaffoldController();
    controller.checkUserProfile(isHomePage);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _scaffold(context),
    );
  }

  Widget _scaffold(BuildContext context) => Scaffold(
        key: scaffoldKey,
        appBar: _appBar(context),
        body: _body(),
        endDrawer: _drawer(),
        floatingActionButton: _floatActionButton(),
      );

  Widget _body() => body;

  Widget _childBottomAppBar() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _divider(),
          _shoppingCart(),
          _divider(),
        ],
      );

  Widget _shoppingCart() => GestureDetector(
        onTap: controller.onTapShoppingCartIcon,
        child: Padding(
          padding: const EdgeInsets.only(left: utils.scaffoldPadding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _shoppingCartIcon(),
              Positioned(
                top: -6,
                right: -5,
                child: _numberText(),
              ),
            ],
          ),
        ),
      );

  Widget _divider() => Divider(
        thickness: 1,
        color: Colors.black.withOpacity(0.6),
      );

  Widget _numberText() => Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(
              50,
            ),
          ),
        ),
        child: CustomScaffoldController.userProfile.value!.drugs.isNotEmpty
            ? Text(
                controller.totalNumberOfDrugsPurchased().toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : null,
      );

  Widget _shoppingCartIcon() => const Icon(
        Icons.shopping_cart,
        size: 32,
      );

  Widget? _floatActionButton() => wantFloatingActionButton
      ? FloatingActionButton(
          onPressed: onPressedFloatingActionButton,
          child: utils.addIcon(),
        )
      : null;

  Widget _backIconButton() => GestureDetector(
        onTap: () => controller.onTapBackIcon(
          isHomePage,
          isLoginPage,
        ),
        child: _backIcon(),
      );

  Widget _backIcon() => const Icon(
        Icons.chevron_left,
      );

  AppBar _appBar(final BuildContext context) => AppBar(
        leading: _backIconButton(),
        title: Text(titleAppBar),
        actions: [
          _drawerIcon(),
        ],
        bottom: (CustomScaffoldController.userProfile.value != null &&
                CustomScaffoldController.userProfile.value!.drugs.isNotEmpty)
            ? PreferredSize(
                preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                child: _childBottomAppBar(),
              )
            : null,
      );

  Widget? _drawer() => wantDrawer
      ? Drawer(
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
                _firstNameText(
                  CustomScaffoldController.userProfile.value?.firstName ?? '',
                ),
                utils.verticalSpacer5,
                _mobileText(
                  CustomScaffoldController.userProfile.value?.mobile ?? '',
                ),
              ],
            ),
          ),
        ],
      );

  Widget _mobileText(final String mobile) => Text(
        mobile,
        style: const TextStyle(fontSize: 16),
      );

  Widget _firstNameText(final String firstName) => Text(
        firstName,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _drawerIcon() => wantDrawer
      ? IconButton(
          onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
          icon: _menuIcon(),
        )
      : const SizedBox.shrink();

  Widget _menuIcon() => const Icon(Icons.menu);

  Widget _exitTextButton() => Align(
        alignment: AlignmentDirectional.bottomStart,
        child: TextButton(
          onPressed: controller.onPressedExit,
          child: Text(
            LocaleKeys.drawer_exit.tr,
            style: _textStyle(),
          ),
        ),
      );

  Widget _changePasswordTextButton() => TextButton(
        onPressed: controller.onPressedChangePassword,
        child: Text(
          LocaleKeys.forgot_password_page_change_password.tr,
          style: _textStyle(),
        ),
      );

  Widget _profileTextButton() => TextButton(
        onPressed: controller.onPressedProfile,
        child: Text(
          LocaleKeys.profile_page_profile.tr,
          style: _textStyle(),
        ),
      );

  Widget _drugsTextButton() => TextButton(
        onPressed: controller.onPressedDrugs,
        child: Text(
          LocaleKeys.home_page_drugs.tr,
          style: _textStyle(),
        ),
      );

  TextButton _pharmaciesTextButton() => TextButton(
        onPressed: controller.onPressedPharmacies,
        child: Text(
          LocaleKeys.home_page_pharmacies.tr,
          style: _textStyle(),
        ),
      );

  _textStyle() => const TextStyle(fontSize: 20);

  Widget _circleImage() => CircleImage(
        base64Image: CustomScaffoldController.userProfile.value?.base64Image,
      );
}
