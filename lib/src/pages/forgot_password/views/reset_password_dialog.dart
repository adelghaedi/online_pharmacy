import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../forgot_password/controllers/reset_password_controller.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart' as utils;

class ResetPasswordDialog extends GetView<ResetPasswordController> {
  final int userId;
  final bool comeFromLoginPage;

  const ResetPasswordDialog({
    super.key,
    required this.userId,
    this.comeFromLoginPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return _alertDialog(context, comeFromLoginPage);
  }

  Widget _alertDialog(BuildContext context, final bool comeFromLoginPage) =>
      AlertDialog(
        title: Text(LocaleKeys.forgot_password_page_change_password.tr),
        contentPadding: const EdgeInsets.all(utils.scaffoldPadding),
        content: _form(
          context,
          comeFromLoginPage,
        ),
      );

  Widget _form(
    BuildContext context,
    final bool comeFromLoginPage,
  ) =>
      Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _newPasswordTextField(),
              utils.verticalSpacer20,
              _confirmPasswordTextField(),
              utils.verticalSpacer40,
              _submitButton(context, userId, comeFromLoginPage),
            ],
          ),
        ),
      );

  Widget _submitButton(
    final BuildContext context,
    final int userId,
    final bool comeFromLoginPage,
  ) =>
      SizedBox(
        height: utils.buttonHeight,
        child: Obx(
          () => ElevatedButton(
            onPressed: () =>
                controller.onPressedSubmit(context, userId, comeFromLoginPage),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.reset_password_dialog_submit.tr,
                ),
                utils.horizontalSpacer10,
                if (controller.isLoading.value) _progressBar()
              ],
            ),
          ),
        ),
      );

  Widget _progressBar() => const Padding(
        padding: EdgeInsets.all(5),
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
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
              hintText: utils.passwordHint,
              suffixIcon: utils.visibilityIconPassword(
                passwordIsVisible: controller.confirmPasswordIsVisible.value,
                togglePassword: controller.toggleConfirmPasswordVisibility,
              ),
              labelText: LocaleKeys.reset_password_dialog_confirm_password.tr),
        ),
      );

  Widget _newPasswordTextField() => Obx(
        () => TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.newPasswordController,
          obscureText: !controller.newPasswordIsVisible.value,
          validator: controller.newPasswordValidator,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-z0-9#]'))
          ],
          decoration: InputDecoration(
              hintText: utils.passwordHint,
              suffixIcon: utils.visibilityIconPassword(
                passwordIsVisible: controller.newPasswordIsVisible.value,
                togglePassword: controller.toggleNewPasswordVisibility,
              ),
              labelText: LocaleKeys.reset_password_dialog_new_password.tr),
        ),
      );
}
