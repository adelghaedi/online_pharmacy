import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/generated/locales.g.dart' as locale;

class LocalizationService extends Translations {
  final Map<String, String> faIR;
  final Map<String, String> enUsa;

  static Locale fallbackLocale = locales.last;

  static final locales = [
    const Locale('en', 'US'),
    const Locale('fa', 'IR'),
  ];

  LocalizationService()
      : faIR = {}..addAll(locale.AppTranslation.translations['fa_IR']!),
        enUsa = {}..addAll(locale.AppTranslation.translations['en_US']!);

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUsa,
        'fa_IR': faIR,
      };

  void changeLocale(final Locale locale) {
    Get.updateLocale(locale);
  }
}
