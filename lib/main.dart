import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lablinker/app/shared/theme/theme_modelview.dart';
import 'package:lablinker/app/views/teste_view/teste_modelview.dart';
import 'package:provider/provider.dart';
import 'app_widget.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              ThemeModelView(isDarkMode: false), // inicia em modo claro
        ),
        ChangeNotifierProvider(
          create: (_) =>
              TesteModelview(), // inicia em modo claro
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
