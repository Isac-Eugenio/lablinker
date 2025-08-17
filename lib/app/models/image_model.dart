import 'package:flutter/material.dart';
import '../shared/enums/images_enum.dart';

class ImageModel extends StatelessWidget {
  final Images image;
  const ImageModel({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image.value);
  }
}