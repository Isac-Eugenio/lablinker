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
import 'app/shared/communication/bluetooth/bluetooth_case.dart';
import 'app/shared/communication/bluetooth/bluetooth_repository.dart';
import 'app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Animate.restartOnHotReload = true;

  runApp(
    MultiProvider(
      providers: [
        // Gerenciamento do tema
        ChangeNotifierProvider(
          create: (_) => ThemeModelView(isDarkMode: false),
        ),

        // Repositório global do Bluetooth
        Provider(create: (_) => BluetoothRepository()),

        // Case global do Bluetooth
        ChangeNotifierProvider(
          create: (context) =>
              BluetoothCase(context.read<BluetoothRepository>()),
        ),
      ],

      child: const AppWidget(),
    ),
  );
}
