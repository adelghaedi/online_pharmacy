import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          _imageAvatar(),
          if (isLoading) _progressBar(),
          _createAccountAdminButton(),
        ],
      ),
    );
  }

  Widget _progressBar() => const Positioned(
        bottom: 120,
        child: CircularProgressIndicator(),
      );

  Widget _createAccountAdminButton() => Positioned(
        bottom: 30,
        child: SizedBox(
          child: OutlinedButton(
            onPressed: _onPressedCreateAccount,
            child: Text(LocaleKeys.splash_page_create_account_admin.tr),
          ),
        ),
      );

  void _onPressedCreateAccount() {}

  Widget _imageAvatar() => Container(
        color: Colors.indigo.withOpacity(0.2),
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
      );

  @override
  void initState() {
    super.initState();
    checkUserLogin();
  }

  Future<void> checkUserLogin() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );

    if (_getStorage.read<String>('userName') != null &&
        _getStorage.read<String>('password') != null) {
      final String userName = _getStorage.read<String>('userName')!;
      final String password = _getStorage.read<String>('password')!;

      Either<String, UserViewModel> result =
          await _repository.login(userName, password);

      result.fold((final exception) {
        Get.offAndToNamed(PharmacyModuleRoutes.loginPage);
        isLoading = false;
      }, (final user) {
        Get.offAndToNamed(PharmacyModuleRoutes.homePage);
        isLoading = false;
      });
    } else {
      Get.offAndToNamed(PharmacyModuleRoutes.loginPage);
      isLoading = false;
    }
  }
}
