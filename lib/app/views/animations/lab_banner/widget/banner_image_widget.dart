import 'package:flutter/material.dart';
import '../../../../shared/enums/images_enum.dart';
import '../../../../models/image_model.dart';


class BannerImageWidget extends StatelessWidget {
  const BannerImageWidget({super.key});

  @override
  Widget build(BuildContext context) => ImageModel(image: Images.logo);
}
