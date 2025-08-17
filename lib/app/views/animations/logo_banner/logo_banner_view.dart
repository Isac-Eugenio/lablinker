import 'package:flutter/material.dart';
import 'package:lablinker/app/views/animations/logo_banner/widget/banner_animation_controller.dart';
import '../../../shared/modelviews/page_navigator_viewmodel.dart';
import '../../../shared/routes/routes.dart';
import '../../../shared/theme/theme_widgets.dart';

class LogoBannerView extends StatelessWidget {
  const LogoBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsPrimarySystem.primaryColor.color,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(2),
          child: BannerAnimationController(
            onTap: () =>
                pageNavigatorViewModel.go(RoutesName.home, context),
          ),
        ),
      ),
    );
  }
}
