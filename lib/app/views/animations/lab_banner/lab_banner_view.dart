import 'package:lablinker/app/views/animations/lab_banner/widget/banner_animation_widget.dart';
import 'package:flutter/material.dart';
import '../../../shared/theme/theme_widgets.dart';

class LabBannerView extends StatelessWidget {
  const LabBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    BannerAnimationWidget bannerAnimationWidget = BannerAnimationWidget();

    return Scaffold(
      backgroundColor: ColorsPrimarySystem.primaryColor.color,
      body: bannerAnimationWidget,
    );
  }
}
