import 'dart:convert';

import 'package:flutter/material.dart';

import '../../infrastructure/utils/utils.dart' as utils;

class CircleImage extends StatelessWidget {
  final String? base64Image;
  final String? imageAssetsUrl;
  final double imageSize;
  final Color backgroundColor;

  const CircleImage({
    super.key,
    this.base64Image,
    this.imageAssetsUrl,
    this.imageSize = 40,
    this.backgroundColor = Colors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    return _circleImage();
  }

  Widget _circleImage() => CircleAvatar(
        backgroundColor: backgroundColor,
        radius: imageSize,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(imageSize)),
          child: _image(),
        ),
      );

  Widget _image() {
    if (base64Image != null) {
      return convertBase64ToImage(base64Image!);
    } else if (imageAssetsUrl != null) {
      return Image.asset(
        imageAssetsUrl!,
        package: utils.packageName,
        fit: BoxFit.fill,
      );
    } else {
      return Icon(
        Icons.person,
        size: imageSize,
      );
    }
  }

  Image convertBase64ToImage(final String base64Image) {
    Image image = Image.memory(
      base64.decode(base64Image),
      fit: BoxFit.fitHeight,
      width: imageSize * 2,
      height: imageSize * 2,
    );
    return image;
  }
}
