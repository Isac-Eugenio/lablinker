import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        /* debugShowCheckedModeBanner: false,
        theme: ThemeWidgets.system.themeData, */
      initialRoute: Routes.initialRoute,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(colorSchemeSeed: Colors.lightBlueAccent, useMaterial3: true),
      
      );
  }
}
