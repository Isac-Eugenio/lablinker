import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/widgets/rollback_button_widget.dart';

import '../routes/routes.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final RoutesName? route;
  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.actions,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: RollbackButtonWidget(route: route),
      titleTextStyle: TextTheme.of(context).titleMedium,
      elevation: 10,
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
