import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/theme/theme_modelview.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initialRoute,
      onGenerateRoute: Routes.generateRoute,
      themeMode: ThemeMode.light, // alterna entre claro e escuro conforme o sistema
      theme: Provider.of<ThemeModelView>(context).value,
    );
  }
}

