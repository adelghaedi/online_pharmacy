import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../infrastructure/utils/utils.dart' as utils;
import 'advance_search_dialog.dart';

class SimpleSearch extends StatefulWidget {
  final void Function(String pharmacyName) onPressedSearchIcon;
  final void Function(Map<String, String> info) onPressedFilterButton;

  const SimpleSearch({
    super.key,
    required this.onPressedSearchIcon,
    required this.onPressedFilterButton,
  });

  @override
  State<SimpleSearch> createState() => _SimpleSearchState();
}

class _SimpleSearchState extends State<SimpleSearch> {
  final TextEditingController _pharmacyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _row();
  }

  Widget _row() => Row(children: [
        Expanded(
          child: _pharmacyNameTextField(),
        ),
        utils.horizontalSpacer10,
        _advanceSearchIconButton(),
      ]);

  Widget _advanceSearchIconButton() => IconButton(
        onPressed: _onPressedAdvancedSearchIcon,
        icon: const Icon(
          Icons.manage_search,
          size: 30,
        ),
      );

  Widget _pharmacyNameTextField() => TextField(
        controller: _pharmacyNameController,
        decoration: InputDecoration(
          hintText: LocaleKeys.pharmacy_page_pharmacy_name.tr,
          suffixIcon: _searchIconButton(),
        ),
      );

  Widget _searchIconButton() => IconButton(
        onPressed: _onPressedSearch,
        icon: _searchIcon(),
      );

  void _onPressedSearch() {
          if (_pharmacyNameController.text.trim().isNotEmpty) {
            widget.onPressedSearchIcon(
              _pharmacyNameController.text,
            );
          }
        }

  Widget _searchIcon() => const Icon(
        Icons.search,
      );

  void _onPressedAdvancedSearchIcon() {
    Get.dialog(
      AdvanceSearchDialog(
        onPressedFilterButton: widget.onPressedFilterButton,
      ),
    );
  }
}
