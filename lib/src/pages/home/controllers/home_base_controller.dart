import 'package:get/get.dart';

abstract class HomeBaseController extends GetxController {
  abstract bool isHomeUser;

  void onTapProfileItem();

  void onTapDrugsItem();

  void onTapPharmaciesItem();

  void onTapShoppingCartItem() {}
}
