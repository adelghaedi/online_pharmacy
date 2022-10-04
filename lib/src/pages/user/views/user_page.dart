import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/user_base_controller.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../shared/circle_image.dart';
import '../../../components/customScaffold/views/custom_scaffold.dart';

class UserPage<T extends UserBaseController> extends GetView<T> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _scaffold(context);
  }

  Widget _scaffold(BuildContext context) => Obx(
        () => Stack(children: [
          Theme(
            data: _themeData(context),
            child: CustomScaffold(
              titleAppBar: controller.addUserPage
                  ? LocaleKeys.login_page_sign_up.tr
                  : LocaleKeys.user_page_edit_info.tr,
              wantDrawer: false,
              wantFloatActionButton: false,
              body: _form(context),
            ),
          ),
          if (controller.isLoading.value) utils.customProgressBar(),
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

  Widget _circleImage() => Obx(
        () => GestureDetector(
          onTap: controller.onTapCircleImage,
          child: CircleImage(
            imageAssetsUrl: utils.personImageUrl,
            backgroundColor: Colors.teal,
            imageSize: 80,
            base64Image: controller.selectedImageUrl.value,
          ),
        ),
      );

  Widget _form(BuildContext context) => Padding(
        padding: const EdgeInsets.all(utils.scaffoldPadding),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circleImage(),
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
                if (controller.addUserPage) _passwordTextField(),
                utils.verticalSpacer20,
                if (controller.addUserPage) _confirmPasswordTextField(),
                utils.verticalSpacer40,
                _button(context),
              ],
            ),
          ),
        ),
      );

  Widget _button(final BuildContext context) => SizedBox(
        height: utils.elevatedButtonHeight,
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.teal.withOpacity(0.8),
              ),
            ),
            onPressed: () => controller.onPressedButton(context),
            child: Text(controller.addUserPage
                ? LocaleKeys.login_page_sign_up.tr
                : LocaleKeys.user_page_edit_info.tr)),
      );

  Widget _birthDateTextField(BuildContext context) => TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller.birthDateController,
      validator: controller.birthDateValidator,
      readOnly: true,
      decoration: InputDecoration(
        labelText: LocaleKeys.user_page_birth_date.tr,
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
          ),
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

  Widget _mobileTextField() => TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller.mobileController,
        validator: controller.mobileValidator,
        maxLength: 11,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: LocaleKeys.user_page_mobile.tr,
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
          labelText: LocaleKeys.user_page_last_name.tr,
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
          labelText: LocaleKeys.user_page_first_name.tr,
          hintText: utils.firstNameHint,
        ),
      );
}
