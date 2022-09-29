import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/sign_up_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) => Obx(
        () => Stack(children: [
          Theme(
            data: _themeData(context),
            child: Scaffold(
              appBar: _appBar(),
              body: _form(context),
            ),
          ),
          if (controller.isLoading.value) _progressBar(),
        ]),
      );

  ThemeData _themeData(final BuildContext context) =>
      Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.teal,
          ),
          inputDecorationTheme: InputDecorationTheme(
            suffixIconColor: Colors.grey,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.teal.withOpacity(0.8),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.teal.withOpacity(0.8),
              ),
            ),
          ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.teal.withOpacity(0.8),
          ));

  Widget _progressBar() => Container(
        alignment: Alignment.center,
        color: Colors.black.withOpacity(0.3),
        child: const CircularProgressIndicator(),
      );

  ImageProvider _image() {
    if (controller.selectedImageUrl.value.isNotEmpty) {
      return FileImage(
        File(controller.selectedImageUrl.value),
      );
    } else {
      return const AssetImage(
        utils.personImageUrl,
        package: utils.packageName,
      );
    }
  }

  Widget _imageUser() => Obx(
        () => GestureDetector(
          onTap: controller.onTapImage,
          child: CircleAvatar(
            radius: 150,
            backgroundImage: _image(),
          ),
        ),
      );

  Widget _form(BuildContext context) => Padding(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _imageUser(),
                utils.verticalSpacer20,
                _firstNameTextField(),
                utils.verticalSpacer20,
                _lastNameTextField(),
                utils.verticalSpacer20,
                _mobileTextField(),
                utils.verticalSpacer20,
                _birthDateTextField(context),
                utils.verticalSpacer20,
                _userNameTextField(),
                utils.verticalSpacer20,
                _passwordTextField(),
                utils.verticalSpacer20,
                _confirmPasswordTextField(),
                utils.verticalSpacer40,
                _signUpButton(context),
              ],
            ),
          ),
        ),
      );

  Widget _signUpButton(final BuildContext context) => SizedBox(
        height: utils.elevatedButtonHeight,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.teal.withOpacity(0.8),
              ),
            ),
            onPressed: () => controller.onPressedSignUp(context),
            child: Text(LocaleKeys.login_page_sign_up.tr)),
      );

  Widget _birthDateTextField(BuildContext context) => TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller.birthDateController,
      validator: controller.birthDateValidator,
      readOnly: true,
      decoration: InputDecoration(
        labelText: LocaleKeys.sign_up_page_birth_date.tr,
        hintText: utils.birthDateHint,
        suffixIcon: _calendarIcon(),
      ),
      onTap: () async {
        await controller.onTapBirthDateTextField(context);
      });

  Widget _calendarIcon() => const Icon(
        Icons.calendar_today,
      );

  Widget _confirmPasswordTextField() => Obx(
        () => TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.confirmPasswordController,
          obscureText: !controller.confirmPasswordIsVisible.value,
          validator: controller.confirmPasswordValidator,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-z0-9#]'))
          ],
          decoration: InputDecoration(
            labelText: LocaleKeys.reset_password_dialog_confirm_password.tr,
            hintText: utils.passwordHint,
            suffixIcon: utils.visibilityIconPassword(
              passwordIsVisible: controller.confirmPasswordIsVisible.value,
              togglePassword: controller.toggleConfirmPasswordVisibility,
            ),
          ),
        ),
      );

  Widget _passwordTextField() => Obx(
        () => TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller.passwordController,
            obscureText: !controller.passwordIsVisible.value,
            validator: controller.passwordValidator,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-z0-9#]'))
            ],
            decoration: InputDecoration(
              labelText: LocaleKeys.login_page_password.tr,
              hintText: utils.passwordHint,
              suffixIcon: utils.visibilityIconPassword(
                passwordIsVisible: controller.passwordIsVisible.value,
                togglePassword: controller.togglePasswordVisibility,
              ),
            )),
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

  Widget _mobileTextField() => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller.mobileController,
        validator: controller.mobileValidator,
        maxLength: 11,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: LocaleKeys.sign_up_page_mobile.tr,
          hintText: utils.mobileHint,
        ),
      );

  Widget _lastNameTextField() => TextFormField(
        controller: controller.lastNameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: controller.lastNameValidator,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(
              '[a-zA-z]',
            ),
          ),
        ],
        decoration: InputDecoration(
          labelText: LocaleKeys.sign_up_page_last_name.tr,
          hintText: utils.lastNameHint,
        ),
      );

  Widget _firstNameTextField() => TextFormField(
      controller: controller.firstNameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: controller.firstNameValidator,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(
            '[a-zA-z]',
          ),
        ),
      ],
      decoration: InputDecoration(
        labelText: LocaleKeys.sign_up_page_first_name.tr,
        hintText: utils.firstNameHint,
      ));

  AppBar _appBar() => AppBar(
        title: Text(
          LocaleKeys.login_page_sign_up.tr,
        ),
        leading: _backIcon(),
      );

  Widget _backIcon() => GestureDetector(
        onTap: controller.onTapBackIcon,
        child: const Icon(
          Icons.chevron_left,
        ),
      );
}
