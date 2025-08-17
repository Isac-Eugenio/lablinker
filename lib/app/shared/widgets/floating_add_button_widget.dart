import 'package:flutter/material.dart';

import '../modelviews/page_navigator_viewmodel.dart';
import '../routes/routes.dart';
import '../theme/theme_widgets.dart';

class FloatingAddButtonWidget extends StatelessWidget {
  const FloatingAddButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          pageNavigatorViewModel.go(RoutesName.formAddSceneGamepad, context),
      backgroundColor: ColorsPrimarySystem.primaryColor.color,
      elevation: 10,
      autofocus: true,
      child: Icon(Icons.add, size: 40, color: Colors.white),
    );
  }
}
