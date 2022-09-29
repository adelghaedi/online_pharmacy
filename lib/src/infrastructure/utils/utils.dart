import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

const String packageName = 'pharmacy';
const String splashImageUrl = 'lib/assets/images/splash_image.png';
const String personImageUrl = 'lib/assets/images/person.png';
const double scaffoldPadding = 12.0;
const String userNameHint = 'adelghaedi';
const String passwordHint = '#12345a';
const String mobileHint = '09334220275';
const String firstNameHint = 'Adel';
const String lastNameHint = 'Ghaedi';
const String birthDateHint = '1383/01/01';

const String baseUrlApi = 'http://10.0.2.2:3000';

const double elevatedButtonHeight = 45.0;

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
