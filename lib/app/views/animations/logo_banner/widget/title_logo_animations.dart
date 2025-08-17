import 'package:flutter/material.dart';

class TitleLogoAnimations {
  late final AnimationController scaleController;
  late final Animation<double> scaleAnimation;

  late final AnimationController waveController;
  late final Animation<double> waveAnimation;

  late final AnimationController hintController;
  late final Animation<double> hintOpacity;
  late final Animation<Offset> hintOffset;

  TitleLogoAnimations(TickerProvider vsync) {
    scaleController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    );

    scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.easeOut),
    );

    waveController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    );

    waveAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(
      CurvedAnimation(parent: waveController, curve: Curves.easeInOut),
    );

    hintController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 800),
    );

    hintOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: hintController, curve: Curves.easeIn),
    );

    hintOffset = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: hintController, curve: Curves.easeOut),
    );
  }

  void dispose() {
    scaleController.dispose();
    waveController.dispose();
    hintController.dispose();
  }
}
