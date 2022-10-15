import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../generated/locales.g.dart';
import '../../infrastructure/utils/utils.dart' as utils;

class AdvanceSearchDialog extends StatefulWidget {
  final void Function(Map<String, String> searchInfo) onPressedFilterButton;

  const AdvanceSearchDialog({
    super.key,
    required this.onPressedFilterButton,
  });

  @override
  State<AdvanceSearchDialog> createState() => _AdvanceSearchDialogState();
}

class _AdvanceSearchDialogState extends State<AdvanceSearchDialog> {
  final TextEditingController _pharmacyNameController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _untilDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _simpleDialog(context);
  }

  Widget _simpleDialog(final BuildContext context) => SimpleDialog(
        contentPadding: const EdgeInsets.all(utils.scaffoldPadding),
        title: _advanceSearchText(),
        children: [
          _pharmacyNameTextField(),
          utils.verticalSpacer20,
          _doctorNameTextField(),
          utils.verticalSpacer20,
          _fromDateTextField(context),
          utils.verticalSpacer20,
          _untilDateTextField(context),
          utils.verticalSpacer20,
          _filterButton()
        ],
      );

  Widget _filterButton() => ElevatedButton(
        onPressed: _onPressedFilter,
        child: Text(
          LocaleKeys.pharmacies_page_filter.tr,
        ),
      );

  Widget _untilDateTextField(final BuildContext context) => TextFormField(
        controller: _untilDateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: LocaleKeys.pharmacies_page_to_date.tr,
          suffixIcon: utils.calendarIcon(),
        ),
        onTap: () => _onTapDateTextField(
          context,
          _untilDateController,
        ),
      );

  Widget _fromDateTextField(final BuildContext context) => TextFormField(
        controller: _fromDateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: LocaleKeys.pharmacies_page_from_date.tr,
          suffixIcon: utils.calendarIcon(),
        ),
        onTap: () => _onTapDateTextField(
          context,
          _fromDateController,
        ),
      );

  Widget _doctorNameTextField() => TextFormField(
        controller: _doctorNameController,
        decoration: InputDecoration(
          hintText: LocaleKeys.pharmacy_page_doctor_name.tr,
        ),
      );

  Widget _pharmacyNameTextField() => TextFormField(
        controller: _pharmacyNameController,
        decoration: InputDecoration(
          hintText: LocaleKeys.pharmacy_page_pharmacy_name.tr,
        ),
      );

  Widget _advanceSearchText() => Text(
        LocaleKeys.pharmacies_page_advance_search.tr,
        textAlign: TextAlign.center,
      );

  void _onTapDateTextField(
    final BuildContext context,
    final TextEditingController controller,
  ) async {
    final int firstYear = Jalali.now().year - 80;

    final Jalali? selectedDate = await showPersianDatePicker(
      context: context,
      initialDate: Jalali(Jalali.now().year),
      firstDate: Jalali(firstYear),
      lastDate: Jalali(Jalali.now().year),
    );

    if (selectedDate != null) {
      controller.text = selectedDate.formatCompactDate();
    }
  }

  void _onPressedFilter() {
    if (_pharmacyNameController.text.isNotEmpty ||
        _doctorNameController.text.isNotEmpty ||
        _fromDateController.text.isNotEmpty ||
        _untilDateController.text.isNotEmpty) {
      widget.onPressedFilterButton({
        'pharmacyName': _pharmacyNameController.text,
        'doctorName': _doctorNameController.text,
        'fromDate': _fromDateController.text,
        'untilDate': _untilDateController.text,
      });
    }
  }
}
