import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../shared/routes/routes.dart';
import 'banner_image_widget.dart';

class BannerAnimationWidget extends StatelessWidget {
  final VoidCallback? onComplete;

  const BannerAnimationWidget({super.key, this.onComplete});

  void go(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed(Routes.logoRoute);
  @override
  Widget build(BuildContext context) {
    BannerImageWidget imageWidget = BannerImageWidget();

    return Center(
      child: imageWidget
          .animate(onComplete: (_) => go(context))
          .scale(
            begin: const Offset(0.1, 0.1),
            end: const Offset(0.8, 0.8),
            duration: 2.seconds,
            curve: Curves.easeOut,
          )
          .then(delay: 1000.ms)
          .blurXY(
            begin: 0,
            end: 20,
            duration: 1.5.seconds,
            curve: Curves.easeOut,
          )
          .fadeOut(duration: 1.5.seconds),
    );
  }
}
