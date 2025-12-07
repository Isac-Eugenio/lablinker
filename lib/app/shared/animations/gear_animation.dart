/*
------------------------------------
Arquivo: gear_animation.dart
Descrição: Widget de animação de engrenagem girando infinitamente. Pode ajustar o tamanho via radius
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GearAnimation extends StatelessWidget {
  // Raio da engrenagem (metade do tamanho do ícone)
  final double radius;

  const GearAnimation({super.key, this.radius = 50});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
      Icon(
        Icons.settings, // Ícone de engrenagem
        color: Colors.white,
        size: radius * 2, // Tamanho baseado no raio
      )
          .animate(
        onPlay: (controller) => controller.repeat(), // Rotação infinita
      )
          .rotate(
        duration: 2.seconds, // Tempo de uma volta completa
        begin: 0, // Início da rotação
        end: 2 * 3.1416, // Uma volta completa (360°)
        curve: Curves.linear, // Velocidade constante
      ),
    );
  }
}
