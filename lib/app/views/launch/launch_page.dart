import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:signals/signals.dart';
import 'package:lablinker/app/shared/animations/gear_animation.dart';
import 'package:lablinker/app/shared/routes/routes.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with TickerProviderStateMixin {
  // Sinais para controlar as animações
  final _scaleAndMoveLeft = signal(false);
  final _showText = signal(false);
  final _separateGearFromText = signal(false);
  final _moveGearToTop = signal(false);
  final _showTapToContinue = signal(false);

  late final EffectCleanup _animationEffect;
  late final AnimationController _blinkingController;
  late final Animation<double> _blinkingAnimation;

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();

    _blinkingController = AnimationController(duration: 700.ms, vsync: this);
    _blinkingAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_blinkingController);

    effect(() {
      if (_showTapToContinue.value) {
        _blinkingController.repeat(reverse: true);
      } else {
        _blinkingController.stop();
      }
    });

    _animationEffect = effect(() {
      _scaleAndMoveLeft.value;
      _showText.value;
      _separateGearFromText.value;
      _moveGearToTop.value;
      _showTapToContinue.value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _startAnimationSequence() {
    Future.delayed(500.ms, () => _scaleAndMoveLeft.value = true);
    Future.delayed(1500.ms, () => _showText.value = true);
    Future.delayed(3500.ms, () => _separateGearFromText.value = true);
    Future.delayed(4000.ms, () => _moveGearToTop.value = true);
    Future.delayed(5500.ms, () => _showTapToContinue.value = true);
  }

  @override
  void dispose() {
    _animationEffect();
    _blinkingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // Use pushNamedAndRemoveUntil para limpar a pilha de navegação
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home,
          (Route<dynamic> route) => false, // Remove todas as rotas anteriores
        );
      },
      child: Scaffold(
        backgroundColor: Colors.blue.shade700,
        body: Stack(
          children: [
            // -------------------- Conteúdo principal (Título e Texto) --------------------
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Texto "LabLinker"
                  AnimatedOpacity(
                    duration: 500.ms,
                    opacity: _showText.value ? 1 : 0,
                    child: const _AnimatedLabLinkerText(),
                  ),
                  const SizedBox(height: 24),
                  // Texto "Toque para continuar"
                  AnimatedBuilder(
                    animation: _blinkingAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _showTapToContinue.value
                            ? _blinkingAnimation.value
                            : 0,
                        child: const Text(
                          'Toque para continuar',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // -------------------- ENGRENAGEM --------------------
            AnimatedPositioned(
              duration: 1.seconds,
              curve: Curves.easeInOut,
              left: _moveGearToTop.value
                  ? (screen.width / 2) - 275
                  : _separateGearFromText.value
                  ? (screen.width / 2) - 260
                  : _scaleAndMoveLeft.value
                  ? (screen.width / 2) - 240
                  : (screen.width / 2) - 35,
              top: _moveGearToTop.value
                  ? (screen.height / 2) - 140
                  : (screen.height / 2) - 35,
              child: AnimatedScale(
                duration: _moveGearToTop.value ? 1.5.seconds : 1.seconds,
                scale: _moveGearToTop.value ? 0.25 : 1,
                curve: Curves.easeInOut,
                child: const GearAnimation(radius: 80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedLabLinkerText extends StatelessWidget {
  const _AnimatedLabLinkerText();

  @override
  Widget build(BuildContext context) {
    const word = 'LabLinker';
    final letters = word.split('');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < letters.length; i++)
          Text(
                letters[i],
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              )
              .animate(delay: (i * 150).ms)
              .fadeIn(duration: 300.ms)
              .moveX(
                begin: 20,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOut,
              ),
      ],
    );
  }
}
