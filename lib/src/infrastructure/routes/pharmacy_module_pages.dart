import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../pages/user/controllers/add_user_controller.dart';
import '../../pages/user/controllers/edit_user_controller.dart';
import '../../pages/pharmacies/commons/edit_pharmacy_binding.dart';
import '../../pages/pharmacies/commons/detail_pharmacy_binding.dart';
import '../../pages/pharmacies/views/detail_pharmacy_page.dart';
import '../../pages/home/commons/home_admin_binding.dart';
import '../../pages/home/views/home_admin_page.dart';
import '../../../pharmacy.dart';
import '../../pages/user/commons/add_admin_binding.dart';
import '../../pages/user/commons/add_user_binding.dart';
import '../../pages/user/commons/edit_admin_binding.dart';
import '../../pages/user/views/user_page.dart';
import '../routes/pharmacy_module_routes.dart';
import '../../pages/forgot_password/views/forgot_password_page.dart';
import '../../pages/forgot_password/commons/forgot_password_binding.dart';
import '../../pages/home/commons/home_binding.dart';
import '../../pages/home/views/home_page.dart';
import '../../pages/splash/views/splash_page.dart';
import '../../pages/login/commons/login_binding.dart';
import '../../pages/login/views/login_page.dart';
import '../../pages/pharmacies/views/pharmacies_page.dart';
import '../../pages/pharmacies/commons/pharmacies_binding.dart';
import '../../pages/pharmacies/commons/add_pharmacy_binding.dart';
import '../../pages/pharmacies/views/pharmacy_page.dart';
import '../../pages/profile/commons/profile_binding.dart';
import '../../pages/profile/views/profile_page.dart';
import '../../pages/pharmacies/controllers/add_pharmacy_controller.dart';
import '../../pages/pharmacies/controllers/edit_pharmacy_controller.dart';
import '../../pages/user/commons/edit_user_binding.dart';

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
  ),
  GetPage(
    name: PharmacyModuleRoutes.addUserPage,
    page: UserPage<AddUserController>.new,
    binding: AddUserBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.addAdminPage,
    page: UserPage<AddUserController>.new,
    binding: AddAdminBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.editUserPage,
    page: UserPage<EditUserController>.new,
    binding: EditUserBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.editAdminPage,
    page: UserPage<EditUserController>.new,
    binding: EditAdminBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.homeAdminPage,
    page: HomeAdminPage.new,
    binding: HomeAdminBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.pharmaciesAdminPage,
    page: PharmaciesPage.new,
    binding: PharmaciesBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.addPharmacyAdminPage,
    page: PharmacyPage<AddPharmacyController>.new,
    binding: AddPharmacyBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.detailPharmacyAdminPage,
    page: DetailPharmacyPage.new,
    binding: DetailPharmacyBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.editPharmacyAdminPage,
    page: PharmacyPage<EditPharmacyController>.new,
    binding: EditPharmacyBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.profileAdminPage,
    page: ProfilePage.new,
    binding: ProfileBinding(),
  ),
];
