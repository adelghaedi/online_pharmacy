import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/forgot_password_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../components/customScaffold/views/custom_scaffold.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        _scaffold(context),
        if (controller.isLoading.value) utils.customProgressBar(),
      ]),
    );
  }

  Widget _scaffold(BuildContext context) => CustomScaffold(
        body: _body(context),
        wantDrawer: false,
        wantFloatActionButton: false,
        titleAppBar: LocaleKeys.login_page_forgot_password.tr,
      );

  Widget _body(BuildContext context) => Padding(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: _form(context),
      );

  Widget _form(BuildContext context) => Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _userNameTextField(),
            utils.verticalSpacer20,
            _mobileTextField(),
            utils.verticalSpacer40,
            _continueButton(context)
          ],
        ),
      );

  Widget _continueButton(final BuildContext context) => SizedBox(
        height: utils.elevatedButtonHeight,
        child: ElevatedButton(
          onPressed: () => controller.onPressedContinueButton(context),
          child: Text(
            LocaleKeys.forgot_password_page_continue.tr,
          ),
        ),
      );

  Widget _userNameTextField() => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller.userNameController,
        validator: controller.userNameValidator,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(
              '[a-zA-z]',
            ),
          ),
        ],
        decoration: InputDecoration(
          hintText: utils.userNameHint,
          labelText: LocaleKeys.login_page_username.tr,
        ),
      );

  Widget _mobileTextField() => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller.mobileController,
        validator: controller.mobileValidator,
        maxLength: 11,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          hintText: utils.mobileHint,
          labelText: LocaleKeys.user_page_mobile.tr,
        ),
      );
}
