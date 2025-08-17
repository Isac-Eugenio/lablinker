import 'package:flutter/material.dart';
import 'package:lablinker/app/views/animations/logo_banner/widget/title_logo_animations.dart';
import '../../../../shared/widgets/custom_gesture_widget.dart';
import 'column_build_widget.dart';

class BannerAnimationController extends StatefulWidget {
  final VoidCallback? onTap;

  const BannerAnimationController({super.key, this.onTap});

  @override
  State<BannerAnimationController> createState() =>
      _BannerAnimationControllerState();
}

class _BannerAnimationControllerState extends State<BannerAnimationController>
    with TickerProviderStateMixin {
  late final TitleLogoAnimations animations;
  bool _showHint = false;

  @override
  void initState() {
    super.initState();

    animations = TitleLogoAnimations(this);

    animations.scaleController.forward();

    animations.scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animations.waveController.repeat(reverse: true);
        setState(() => _showHint = true);
        animations.hintController.forward();
      }
    });
  }

  @override
  void dispose() {
    animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomGestureWidget(
      onTap: widget.onTap,
      child: ColumnBuildWidget(animations: animations, showHint: _showHint),
    );
  }
}
