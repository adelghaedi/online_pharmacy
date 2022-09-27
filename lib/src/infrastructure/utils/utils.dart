import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

const String packageName = 'pharmacy';
const String splashImageUrl = 'lib/assets/images/splash_image.png';
const double scaffoldPadding = 12.0;
const String userNameHint='adelghaedi';
const String passwordHint='#12345a';
const String mobileHint='09334220275';

const SizedBox verticalSpacer20 = SizedBox(
  height: 20,
);

const SizedBox verticalSpacer40 = SizedBox(
  height: 40,
);

const SizedBox horizontalSpacer10 = SizedBox(
  width: 10,
);

const String baseUrlApi = 'http://127.0.0.1:3000';

const double elevatedButtonHeight = 45.0;

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
