import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/widgets/custom_app_bar_widget.dart';

import '../../../shared/theme/theme_widgets.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(
      title: "Menu",
      route: null,
      actions: [
        PopupMenuButton<String>(
          elevation: 10,
          iconSize: 35,
          color: ColorsPrimarySystem.primaryColor.color,
          onSelected: (String result) {
            log(result); // Handle what happens when an item is selected
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Edit',
              child: Text('Edit ✏️', style: TextTheme.of(context).titleSmall),
            ),
            PopupMenuItem<String>(
              value: 'Delete',
              child: Text(
                'Delete 🗑️',
                style: TextTheme.of(context).titleSmall,
              ),
            ),
            PopupMenuItem<String>(
              value: 'Settings',
              child: Text(
                'Settings ⚙️',
                style: TextTheme.of(context).titleSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
