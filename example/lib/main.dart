import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/pharmacy.dart' as pharmacy;
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: pharmacy.lightTheme,
      darkTheme: pharmacy.darkTheme,
      fallbackLocale: pharmacy.LocalizationService.fallbackLocale,
      locale: pharmacy.LocalizationService.fallbackLocale,
      translations: pharmacy.LocalizationService(),
      debugShowCheckedModeBanner: false,
      getPages: pharmacy.pages,
      initialRoute: pharmacy.PharmacyModuleRoutes.splashPage,
    );
  }
}
