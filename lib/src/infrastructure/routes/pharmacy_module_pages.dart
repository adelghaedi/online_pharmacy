import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../../pharmacy.dart';
import '../routes/pharmacy_module_routes.dart';
import '../../pages/forgot_password/views/forgot_password_page.dart';
import '../../pages/forgot_password/commons/forgot_password_binding.dart';
import '../../pages/home/commons/home_binding.dart';
import '../../pages/home/views/home_page.dart';
import '../../pages/splash/views/splash_page.dart';

import '../../pages/login/commons/login_binding.dart';
import '../../pages/login/views/login_page.dart';

List<GetPage> pages = [
  GetPage(
    name: PharmacyModuleRoutes.splashPage,
    page: () => const SplashPage(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.loginPage,
    page: LoginPage.new,
    binding: LoginBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.forgotPasswordPage,
    page: ForgotPasswordPage.new,
    binding: ForgotPasswordBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.homePage,
    page: HomePage.new,
    binding: HomeBinding(),
  )
];
