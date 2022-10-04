import 'package:flutter/material.dart';
import '../../infrastructure/utils/utils.dart' as utils;

class CircleImage extends StatelessWidget {
  final String? base64Image;
  final String imageAssetsUrl;
  final double imageSize;
  final Color backgroundColor;

  const CircleImage({
    super.key,
    this.base64Image,
    required this.imageAssetsUrl,
    this.imageSize = 40,
    this.backgroundColor = Colors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    return _image();
  }

  Widget _image() => CircleAvatar(
        radius: imageSize,
        backgroundImage: _backgroundImage(),
        backgroundColor: backgroundColor,
      );

  ImageProvider _backgroundImage() {
    if (base64Image != null) {
      return utils.convertBase64ToImage(base64Image!);
    } else {
      return AssetImage(
        imageAssetsUrl,
        package: utils.packageName,
      );
    }
  }
}
