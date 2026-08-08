/*
------------------------------------
Arquivo: app_widget.dart
Descrição: Widget raiz do app. Configura rotas, tema e inicialização do MaterialApp
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/route_context.dart';
import 'package:lablinker/app/shared/routes/route_observer.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/theme/theme_app.dart';
import 'package:lablinker/app/shared/widgets/notification_widget.dart';

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

      // navegador global para acessar um context estatico
      navigatorKey: RouteContext.navigatorKey,

      // Observer para gerenciar as rotas anteriores e atuais
      navigatorObservers: [RouteObserverApp()],

      scaffoldMessengerKey: NotificationWidget.scaffoldMessengerKey,

      // Define o modo de tema (claro/escuro) baseado no sistema
      themeMode: ThemeMode.light,
      // Aplica o tema atual do provider ThemeModelView
      theme: ThemeApp.themeData,
    );
  }
}
