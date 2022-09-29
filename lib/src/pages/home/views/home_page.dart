import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/generated/locales.g.dart';

import '../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  AppBar _appBar() => AppBar(
        title: Text(LocaleKeys.home_page_pharmacy.tr),
        actions: [
          _backIcon(),
        ],
      );

  Widget _backIcon() => const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.chevron_right,
        ),
      );
}
