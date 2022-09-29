import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toast/toast.dart';

import '../repositories/splash_repository.dart';
import '../../../pages/shared/user_view_model.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart' as utils;
import '../../../infrastructure/routes/pharmacy_module_routes.dart';
import '../../shared/repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final GetStorage _getStorage = GetStorage();
  final Repository _repository = Repository();
  final SplashRepository _splashRepository = SplashRepository();

  bool isLoading = true;

  bool notHaveAdmin = true;

  @override
  void initState() {
    super.initState();
    checkExistsAdmin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() => ColoredBox(
        color: Colors.indigo.withOpacity(0.2),
        child: Column(
          children: [
            _imageAvatar(),
            if (isLoading) _progressBar(),
            utils.verticalSpacer20,
            if (notHaveAdmin) _createAccountAdminButton(),
            utils.verticalSpacer20,
          ],
        ),
      );

  Widget _progressBar() => const CircularProgressIndicator();

  Widget _createAccountAdminButton() => SizedBox(
        child: OutlinedButton(
          onPressed: _onPressedCreateAccount,
          child: Text(LocaleKeys.splash_page_create_account_admin.tr),
        ),
      );

  Widget _imageAvatar() => Expanded(
        child: Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: Colors.indigo.withOpacity(0.8),
            radius: 120,
            child: Image.asset(
              width: 200,
              height: 200,
              utils.splashImageUrl,
              package: utils.packageName,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  void _onPressedCreateAccount() {
    Get.offAndToNamed(PharmacyModuleRoutes.signUpAdminPage);
  }

  Future<void> checkExistsAdmin(final BuildContext context) async {
    ToastContext().init(context);

    Either<String, UserViewModel> result =
        await _splashRepository.checkExistsAdmin();

    await result.fold(_existsAdminException, _existsAdminSuccessful);
  }

  Future<void> _userLoggedInException(final exception) async {
    await Get.offAndToNamed(PharmacyModuleRoutes.loginPage);
  }

  Future<void> _userLoggedInSuccessful(final UserViewModel user) async {
    await Get.offAndToNamed(PharmacyModuleRoutes.homePage);
  }

  Future<void> _existsAdminException(final String exception) async {
    await _delay();
  }

  Future<void> _existsAdminSuccessful(final UserViewModel user) async {
    notHaveAdmin = false;

    await _checkUserLoggedIn();

    await _delay();

    Get.offAndToNamed(PharmacyModuleRoutes.loginPage);
    isLoading = false;
  }

  Future<void> _checkUserLoggedIn() async {
    if (_getStorage.read<String>('userName') != null &&
        _getStorage.read<String>('password') != null) {
      final String userName = _getStorage.read<String>('userName')!;
      final String password = _getStorage.read<String>('password')!;

      Either<String, UserViewModel> result =
          await _repository.getUserInfo(userName, password);

      await _delay();

      await result.fold(_userLoggedInException, _userLoggedInSuccessful);
    }
  }

  Future<void> _delay() async {
    await Future.delayed(const Duration(
      seconds: 3,
    ));
  }
}
