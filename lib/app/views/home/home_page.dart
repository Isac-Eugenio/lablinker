import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/widgets/app_bar_widget.dart';
import 'package:lablinker/app/views/home/item_page_widget.dart';

class AdaptiveGridMenu extends StatelessWidget {
  final List<Widget> items;
  const AdaptiveGridMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // calcula automaticamente o número de colunas
        int crossAxisCount = items.length <= 2 ? items.length : (sqrt(items.length)).ceil();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            physics: const NeverScrollableScrollPhysics(),
            children: items,
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Menu', rollback: false),
      body: SafeArea(
        child: AdaptiveGridMenu(
          items: [
            ItemPageWidget(title: 'Gamepad', icon: Icons.videogame_asset, route: Routes.gamepad),
            const ItemPageWidget(title: 'IOT', icon: Icons.sensors),
            ItemPageWidget(title: 'Consoles', icon: Icons.message, route: Routes.consoles),
            const ItemPageWidget(title: 'Configurações', icon: Icons.settings),
          ],
        ),
      ),
    );
  }
}
