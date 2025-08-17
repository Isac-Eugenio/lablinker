import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'app/shared/modelviews/bluetooth_modelview.dart';
import 'app/shared/modelviews/http_modelview.dart';
import 'app_widget.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BluetoothModelView("some description"),
        ),
        ChangeNotifierProvider(
          create: (_) => HttpModelView("some description"),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}