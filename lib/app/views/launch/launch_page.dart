import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lablinker/app/shared/routes/routes.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with TickerProviderStateMixin {
  late final AnimationController _lettersController;
  late final AnimationController _waveController;
  late final AnimationController _tapController;

  final String _word = 'LabLinker';
  final String _subtitle = 'O Poder do Maker';

  bool _showSubtitle = false;
  bool _showTapText = false;

  @override
  void initState() {
    super.initState();

    // Controla a animação de cada letra aparecendo grande -> normal
    _lettersController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150 * _word.length + 400),
    );

    // Controla a animação wave
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Controla o texto piscante
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Sequência das animações
    _lettersController.forward().whenComplete(() async {
      await _waveController.forward(); // Wave apenas uma vez
      await _waveController.reverse();

      setState(() => _showSubtitle = true);

      // Pequeno delay antes de mostrar o texto de toque
      await Future.delayed(const Duration(milliseconds: 600));
      setState(() => _showTapText = true);
      _tapController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _lettersController.dispose();
    _waveController.dispose();
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final letters = _word.split('');

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(Routes.home); // Ajuste a rota
      },
      child: Scaffold(
        backgroundColor: Colors.blue.shade700,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ------------------- Título LabLinker -------------------
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(letters.length, (i) {
                  final start = i / letters.length;
                  final end = (i + 1) / letters.length;

                  final appear = Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: _lettersController,
                      curve: Interval(start, end, curve: Curves.easeOut),
                    ),
                  );

                  final scale = Tween<double>(begin: 2, end: 1).animate(
                    CurvedAnimation(
                      parent: _lettersController,
                      curve: Interval(start, end, curve: Curves.easeOutBack),
                    ),
                  );

                  final wave = Tween<double>(begin: 10, end: 0).animate(
                    CurvedAnimation(
                      parent: _waveController,
                      curve: Interval(start, end, curve: Curves.easeInOut),
                    ),
                  );

                  return AnimatedBuilder(
                    animation: Listenable.merge([
                      _lettersController,
                      _waveController,
                    ]),
                    builder: (context, child) {
                      return Opacity(
                        opacity: appear.value,
                        child: Transform.translate(
                          offset: Offset(0, wave.value),
                          child: Transform.scale(
                            scale: scale.value,
                            child: Text(
                              letters[i],
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 20),

              // ------------------- Subtítulo / lema -------------------
              AnimatedOpacity(
                duration: 600.ms,
                opacity: _showSubtitle ? 1 : 0,
                child: Text(
                  _subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),

              const SizedBox(height: 16),

              // ------------------- Toque para continuar -------------------
              AnimatedBuilder(
                animation: _tapController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _showTapText ? _tapController.value : 0,
                    child: Text(
                      'Toque para continuar',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
