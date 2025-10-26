// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actionsAppBar;
  final bool rollback;
  final String? route;
  final String title;

  const AppBarWidget({
    super.key,
    this.actionsAppBar,
    required this.rollback,
    this.route,
    required this.title,
  });
  
  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(title),
    centerTitle: true,
    leading: rollback
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (route != null) {
                Navigator.of(context).pushReplacementNamed(route!);
              } else {
                Navigator.of(context).pop();
              }
            },
          )
        : null,
    actions: actionsAppBar,
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
