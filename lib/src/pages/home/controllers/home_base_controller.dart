import 'package:get/get.dart';

import '../../../infrastructure/routes/pharmacy_module_routes.dart';

abstract class HomeBaseController extends GetxController {
  abstract bool isHomeUser;

  void onTapProfileItem();

  void onTapDrugsItem();

  void onTapPharmaciesItem();

  void onTapShoppingCartItem() {
    Get.toNamed(PharmacyModuleRoutes.shoppingCartPage);
  }
}
