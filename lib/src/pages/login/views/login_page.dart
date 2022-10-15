import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../components/custom_scaffold/controllers/custom_scaffold_controller.dart';
import '../controllers/login_controller.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../components/custom_scaffold/views/custom_scaffold.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(CustomScaffoldController.new);
    return Obx(
      () => Stack(
        children: [
          _scaffold(context),
          if (controller.isLoading.value) utils.customProgressBar(),
        ],
      ),
    );
  }

  Widget _scaffold(BuildContext context) => CustomScaffold(
        titleAppBar: LocaleKeys.login_page_login.tr,
        wantFloatingActionButton: false,
        wantDrawer: false,
        body: _form(context),
        isLoginPage: true,
      );

  Widget _form(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: Center(
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _userNameTextField(),
                  utils.verticalSpacer20,
                  _passwordTextField(),
                  _forgotPasswordButton(),
                  utils.verticalSpacer40,
                  _loginButton(context),
                  utils.verticalSpacer40,
                  _signUpContainer(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _signUpContainer() => Container(
        decoration: utils.decorationContainer(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.login_page_not_a_member.tr),
            _signUpLink()
          ],
        ),
      );

  Widget _signUpLink() => TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
          Colors.indigo.withOpacity(0.8),
        )),
        onPressed: controller.onPressedSignUp,
        child: Text(LocaleKeys.login_page_sign_up.tr),
      );

  Widget _loginButton(final BuildContext context) => SizedBox(
        width: double.infinity,
        height: utils.buttonHeight,
        child: ElevatedButton(
          onPressed: () => controller.onPressedLogin(context),
          child: Text(
            LocaleKeys.login_page_login.tr,
          ),
        ),
      );

  Widget _forgotPasswordButton() => TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
          Colors.indigo.withOpacity(0.8),
        )),
        onPressed: controller.onPressedForgotPassword,
        child: Text(LocaleKeys.login_page_forgot_password.tr),
      );

  Widget _userNameTextField() => TextFormField(
        controller: controller.userNameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          labelText: LocaleKeys.login_page_username.tr,
          hintText: utils.userNameHint,
        ),
      );

  Widget _passwordTextField() => Obx(
        () => TextFormField(
          controller: controller.passwordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: controller.passwordValidator,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9#]'))
          ],
          obscureText: !controller.passwordIsVisible.value,
          decoration: InputDecoration(
            hintText: utils.passwordHint,
            labelText: LocaleKeys.login_page_password.tr,
            suffixIcon: _visibilityIconPassword(),
          ),
        ),
      );

  Widget _visibilityIconPassword() => GestureDetector(
        onTap: controller.togglePasswordVisibility,
        child: Icon(
          !controller.passwordIsVisible.value
              ? Icons.visibility
              : Icons.visibility_off,
        ),
      );
}
