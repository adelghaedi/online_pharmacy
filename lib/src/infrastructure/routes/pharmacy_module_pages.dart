import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../pages/drugs/admin_drugs/commons/drugs_admin_binding.dart';
import '../../pages/pharmacies/admin_pharmacies/commons/add_pharmacy_binding.dart';
import '../../pages/pharmacies/admin_pharmacies/commons/detail_pharmacy_binding.dart';
import '../../pages/pharmacies/admin_pharmacies/controllers/add_pharmacy_controller.dart';
import '../../pages/pharmacies/admin_pharmacies/controllers/edit_pharmacy_controller.dart';
import '../../pages/pharmacies/admin_pharmacies/views/detail_pharmacy_page.dart';
import '../../pages/pharmacies/admin_pharmacies/views/pharmacies_admin_page.dart';
import '../../pages/pharmacies/admin_pharmacies/views/pharmacy_page.dart';
import '../../pages/pharmacies/user_pharmacies/commons/pharmacies_user_binding.dart';
import '../../pages/shopping_cart/views/shopping_cart_page.dart';
import '../../pages/shopping_cart/commons/shopping_cart_binding.dart';
import '../../pages/pharmacies_with_drug_selected/views/pharmacies_with_drug_selected_page.dart';
import '../../pages/pharmacies_with_drug_selected/commons/pharmacies_with_drug_selected_binding.dart';
import '../../pages/drug_purchase/commons/drug_purchase_binding.dart';
import '../../pages/drug_purchase/views/drug_purchase_page.dart';
import '../../pages/drug_purchase/views/drug_purchase_details_page.dart';
import '../../pages/drug_purchase/commons/drug_purchase_details_binding.dart';
import '../../pages/pharmacy_drug_management/views/pharmacy_drug_management_page.dart';
import '../../pages/pharmacy_drug_management/commons/pharmacy_drug_management_binding.dart';
import '../../pages/drugs/user_drugs/views/drugs_user_page.dart';
import '../../pages/drugs/user_drugs/commons/drugs_user_binding.dart';
import '../../pages/drugs/admin_drugs/views/drugs_admin_page.dart';
import '../../pages/pharmacies/admin_pharmacies/commons/pharmacies_admin_binding.dart';

import '../../pages/pharmacies/user_pharmacies/views/pharmacies_user_page.dart';
import '../../pages/profile/controllers/profile_admin_controller.dart';
import '../../pages/profile/controllers/profile_user_controller.dart';
import '../../pages/profile/commons/profile_user_binding.dart';
import '../../pages/home/commons/home_user_binding.dart';
import '../../pages/home/controllers/home_user_controller.dart';
import '../../pages/home/controllers/home_admin_controller.dart';
import '../../pages/user/controllers/add_user_controller.dart';
import '../../pages/user/controllers/edit_user_controller.dart';
import '../../pages/pharmacies/admin_pharmacies/commons/edit_pharmacy_binding.dart';

import '../../pages/home/commons/home_admin_binding.dart';
import '../../pages/home/views/home_page.dart';
import '../../../pharmacy.dart';
import '../../pages/user/commons/add_admin_binding.dart';
import '../../pages/user/commons/add_user_binding.dart';
import '../../pages/user/commons/edit_admin_binding.dart';
import '../../pages/user/views/user_page.dart';
import '../routes/pharmacy_module_routes.dart';
import '../../pages/forgot_password/views/forgot_password_page.dart';
import '../../pages/forgot_password/commons/forgot_password_binding.dart';
import '../../pages/splash/views/splash_page.dart';
import '../../pages/login/commons/login_binding.dart';
import '../../pages/login/views/login_page.dart';

import '../../pages/profile/commons/profile_admin_binding.dart';
import '../../pages/profile/views/profile_page.dart';

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
    name: PharmacyModuleRoutes.pharmaciesAdminPage,
    page: PharmaciesAdminPage.new,
    binding: PharmaciesAdminBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.pharmaciesUserPage,
    page: PharmaciesUserPage.new,
    binding: PharmaciesUserBinding(),
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
    page: ProfilePage<ProfileAdminController>.new,
    binding: ProfileAdminBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.profileUserPage,
    page: ProfilePage<ProfileUserController>.new,
    binding: ProfileUserBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.drugsAdminPage,
    page: DrugsAdminPage.new,
    binding: DrugsAdminBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.drugsUserPage,
    page: DrugsUserPage.new,
    binding: DrugsUserBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.homeUserPage,
    page: HomePage<HomeUserController>.new,
    binding: HomeUserBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.homeAdminPage,
    page: HomePage<HomeAdminController>.new,
    binding: HomeAdminBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.pharmacyDrugManagementPage,
    page: PharmacyDrugManagementPage.new,
    binding: PharmacyDrugManagementBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.drugPurchasePage,
    page: DrugPurchasePage.new,
    binding: DrugPurchaseBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.drugPurchaseDetailsPage,
    page: DrugPurchaseDetailsPage.new,
    binding: DrugPurchaseDetailsBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.pharmaciesWithDrugSelectedPage,
    page: PharmaciesWithDrugSelectedPage.new,
    binding: PharmaciesWithDrugSelectedBinding(),
  ),
  GetPage(
    name: PharmacyModuleRoutes.shoppingCartPage,
    page: ShoppingCartPage.new,
    binding: ShoppingCartBinding(),
  ),
];
