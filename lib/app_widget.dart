import 'package:flutter/material.dart';
import 'app/shared/routes/routes.dart';
import 'app/shared/theme/theme_widgets.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initialRoute,
        onGenerateRoute: Routes.generateRoute,
        theme: ThemeWidgets.system.themeData,
      );
  }
}
