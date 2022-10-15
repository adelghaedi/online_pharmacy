import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../infrastructure/utils/utils.dart' as utils;

class AddToCartButton extends StatelessWidget {
  int number;
  final void Function(int) onPressedAddToCartButton;
  final Color outlineBorderColor;

  AddToCartButton({
    super.key,
    required this.number,
    required this.onPressedAddToCartButton,
    this.outlineBorderColor = Colors.pink,
  });

  @override
  Widget build(BuildContext context) {
    return _addToCartButton();
  }

  Widget _addToCartButton() => OutlinedButton(
        onPressed: _onPressedButton,
        style: _addToCartButtonStyle(),
        child: (number == 0) ? _addToCartText() : _row(),
      );

  Widget _row() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _addIconButton(),
            utils.horizontalSpacer10,
            _numberText(),
            utils.horizontalSpacer10,
            _removeIconButton(),
          ],
        ),
      );

  ButtonStyle _addToCartButtonStyle() => ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            width: 1.5,
            color: outlineBorderColor.withOpacity(0.5),
          ),
        ),
      );

  Widget _addToCartText() => Text(
        LocaleKeys.buy_drug_page_add_to_cart.tr,
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
        ),
      );

  Widget _numberText() => Text(
        number.toString(),
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontSize: 18,
        ),
      );

  Widget _removeIconButton() => GestureDetector(
        onTap: _onTapRemoveIcon,
        child: Container(
          decoration: _decorationContainer(
            Colors.red,
          ),
          child: _removeIcon(),
        ),
      );

  Widget _removeIcon() => const Icon(
        Icons.remove,
        color: Colors.red,
      );

  Widget _addIconButton() => GestureDetector(
        onTap: _onTapAddIcon,
        child: Container(
          decoration: _decorationContainer(Colors.green),
          child: utils.addIcon(color: Colors.green),
        ),
      );

  BoxDecoration _decorationContainer(
    final Color borderColor,
  ) =>
      BoxDecoration(
        color: borderColor.withOpacity(0.1),
        border: Border.all(
          color: borderColor,
        ),
        shape: BoxShape.circle,
      );

  void _onTapRemoveIcon() async {
    if (number > 0) {
      onPressedAddToCartButton(number -= 1);
    }
  }

  void _onTapAddIcon() {
    onPressedAddToCartButton(number += 1);
  }

  void _onPressedButton() async {
    if (number == 0) {
      onPressedAddToCartButton(number += 1);
    }
  }
}
