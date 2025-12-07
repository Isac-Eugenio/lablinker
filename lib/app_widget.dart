/*
------------------------------------
Arquivo: app_widget.dart
Descrição: Widget raiz do app. Configura rotas, tema e inicialização do MaterialApp
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/theme/theme_modelview.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove a faixa de debug no canto superior
      debugShowCheckedModeBanner: false,

      // Rota inicial do app
      initialRoute: Routes.initialRoute,

      // Gera rotas dinamicamente conforme a navegação
      onGenerateRoute: Routes.generateRoute,

      // Define o modo de tema (claro/escuro) baseado no sistema
      themeMode: ThemeMode.light,

      // Aplica o tema atual do provider ThemeModelView
      theme: Provider.of<ThemeModelView>(context).value,
    );
  }
}
