import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: _appBar(),
            body: Padding(
              padding: const EdgeInsets.all(utils.scaffoldPadding),
              child: Center(
                child: _form(context),
              ),
            ),
          ),
          if (controller.isLoading.value) _progressBar()
        ],
      ),
    );
  }

  Widget _progressBar() => Container(
        alignment: Alignment.center,
        color: Colors.black.withOpacity(0.3),
        child: const CircularProgressIndicator(),
      );

  Widget _form(final BuildContext context) => Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
      );

  Widget _signUpContainer() => Container(
        decoration: _boxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.login_page_not_a_member.tr),
            _signUpLink()
          ],
        ),
      );

  BoxDecoration _boxDecoration() => BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: Colors.indigo.withOpacity(0.8),
        ),
      );

  Widget _signUpLink() => TextButton(
      onPressed: controller.onPressedSignUp,
      child: Text(LocaleKeys.login_page_sign_up.tr));

  Widget _loginButton(final BuildContext context) => SizedBox(
        width: double.infinity,
        height: utils.elevatedButtonHeight,
        child: ElevatedButton(
          onPressed: () => controller.onPressedLogin(context),
          child: Text(
            LocaleKeys.login_page_login.tr,
          ),
        ),
      );

  Widget _forgotPasswordButton() => TextButton(
        onPressed: controller.onPressedForgotPassword,
        child: Text(LocaleKeys.login_page_forgot_password.tr),
      );

  AppBar _appBar() => AppBar(
        leading: _backIcon(),
        title: Text(
          LocaleKeys.login_page_login.tr,
        ),
      );

  Widget _backIcon() => GestureDetector(
        onTap: controller.onTapBackIcon,
        child: const Icon(
          Icons.chevron_left,
        ),
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
