import 'package:flutter/material.dart';
import 'package:lablinker/app/views/animations/logo_banner/widget/title_logo_animations.dart';

class ColumnBuildWidget extends StatelessWidget {
  final TitleLogoAnimations animations;
  final bool showHint;

  const ColumnBuildWidget({
    super.key,
    required this.animations,
    required this.showHint,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([
            animations.scaleController,
            animations.waveController,
          ]),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, animations.waveAnimation.value),
              child: Transform.scale(
                scale: animations.scaleAnimation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text('LabLinker', style: textTheme.titleLarge),
                    Text('LabLinker', style: textTheme.titleLarge),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        if (showHint)
          FadeTransition(
            opacity: animations.hintOpacity,
            child: SlideTransition(
              position: animations.hintOffset,
              child: Text('Pressione para entrar', style: textTheme.titleSmall),
            ),
          ),
      ],
    );
  }
}
