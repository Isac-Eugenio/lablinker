import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'app/shared/theme/theme_modelview.dart';
import 'app/views/bluetooth/bluetooth_case.dart';
import 'app/views/bluetooth/bluetooth_model_view.dart';
import 'app/views/bluetooth/bluetooth_repository.dart';
import 'app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // <<< essencial antes de qualquer coisa

  Animate.restartOnHotReload = true;

  final bluetoothRepository = BluetoothRepository();
  final bluetoothCase = BluetoothCase(bluetoothRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeModelView(isDarkMode: false),
        ),
        ChangeNotifierProvider(
          create: (_) => BluetoothModelView(bluetoothCase),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
