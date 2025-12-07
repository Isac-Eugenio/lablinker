/*
------------------------------------
Arquivo: main.dart
Descrição: Ponto de entrada do app Flutter. Inicializa bindings, animações e providers
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'app/shared/theme/theme_modelview.dart';
import 'app/views/bluetooth/bluetooth_case.dart';
import 'app/views/bluetooth/bluetooth_model_view.dart';
import 'app/views/bluetooth/bluetooth_repository.dart';
import 'app_widget.dart';

void main() {
  // Garante que o Flutter esteja pronto antes de qualquer inicialização
  WidgetsFlutterBinding.ensureInitialized();

  // Reinicia animações automaticamente ao dar hot reload
  Animate.restartOnHotReload = true;

  // Instancia o repositório e o case de Bluetooth
  final bluetoothRepository = BluetoothRepository();
  final bluetoothCase = BluetoothCase(bluetoothRepository);

  // Inicializa o app com múltiplos providers (Theme e Bluetooth)
  runApp(
    MultiProvider(
      providers: [
        // Provider para gerenciar o tema (claro/escuro)
        ChangeNotifierProvider(
          create: (_) => ThemeModelView(isDarkMode: false),
        ),
        // Provider para gerenciar estado do Bluetooth
        ChangeNotifierProvider(
          create: (_) => BluetoothModelView(bluetoothCase),
        ),
      ],
      // Widget raiz do app
      child: const AppWidget(),
    ),
  );
}
