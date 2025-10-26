import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GearAnimation extends StatelessWidget {
  final double radius;

  const GearAnimation({super.key, this.radius = 50});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Icon(
                Icons.settings, // ícone de engrenagem
                color: Colors.white,
                size: radius * 2,
              )
              .animate(
                onPlay: (controller) => controller.repeat(), // rotação infinita
              )
              .rotate(
                duration: 2.seconds, // velocidade da rotação
                begin: 0,
                end: 2 * 3.1416, // uma volta completa
                curve: Curves.linear,
              ),
    );
  }
}
