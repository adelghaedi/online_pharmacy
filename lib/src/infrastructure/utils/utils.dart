import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../../../generated/locales.g.dart';

const String packageName = 'pharmacy';
const String splashImageUrl = 'lib/assets/images/splash_image.png';
const String personImageUrl = 'lib/assets/images/person.png';
const String pharmacyImageUrl = 'lib/assets/images/pharmacy.png';
const double scaffoldPadding = 12.0;
const String userNameHint = 'adelghaedi';
const String passwordHint = '#12345a';
const String mobileHint = '09334220275';
const String firstNameHint = 'Adel';
const String lastNameHint = 'Ghaedi';
const String birthDateHint = '1383/01/01';

const String baseUrlApi = 'http://10.0.2.2:3000';

const String endPointUrlApiUsers = '/Users';

const String endPointUrlApiPharmacies = '/Pharmacies';

const double elevatedButtonHeight = 45.0;

const SizedBox verticalSpacer5 = SizedBox(
  height: 5,
);

const SizedBox verticalSpacer20 = SizedBox(
  height: 20,
);

const SizedBox verticalSpacer40 = SizedBox(
  height: 40,
);

const SizedBox horizontalSpacer10 = SizedBox(
  width: 10,
);

void customToast({
  required final String msg,
  final Color backgroundColor = Colors.indigo,
}) {
  Toast.show(
    msg,
    gravity: Toast.bottom,
    backgroundColor: backgroundColor,
    duration: Toast.lengthLong,
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  );
}

BoxDecoration decorationContainer() => BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      border: Border.all(
        width: 1.5,
        color: Colors.indigo.withOpacity(0.8),
      ),
    );

Widget visibilityIconPassword(
        {required final bool passwordIsVisible,
        required final VoidCallback togglePassword}) =>
    GestureDetector(
      onTap: togglePassword,
      child: Icon(
        !passwordIsVisible ? Icons.visibility : Icons.visibility_off,
      ),
    );

Widget drawerDivider() => const Divider(
      thickness: 1.5,
    );

Widget customProgressBar() => Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.3),
      child: const CircularProgressIndicator(),
    );

Widget subTitleListTile(final String subtitle) => Text(
      subtitle,
      style: const TextStyle(
        fontSize: 16,
      ),
    );

Widget titleListTile(final String title) => Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );

Widget editInfoButton(final VoidCallback onPressed) => SizedBox(
      height: elevatedButtonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          LocaleKeys.detail_pharmacy_page_edit.tr,
        ),
      ),
    );

ImageProvider convertBase64ToImage(final String base64Image) {
  MemoryImage image = MemoryImage(
    base64.decode(base64Image),
  );
  return image;
}

String convertImageToBase64(final String imageUrl) {
  List<int> imageBytes = File(imageUrl).readAsBytesSync();
  String base64Image = base64.encode(imageBytes);
  return base64Image;
}
