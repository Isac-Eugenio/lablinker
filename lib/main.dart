import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lablinker/app/shared/cases/bluetooth_case.dart';
import 'package:lablinker/app/shared/theme/theme_modelview.dart';
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
              BluetoothCase(),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
