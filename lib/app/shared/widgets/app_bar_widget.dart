/*
------------------------------------
Arquivo: app_bar_widget.dart
Descrição: Widget customizado de AppBar com suporte a título centralizado, ações e botão de retorno opcional
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  // Lista de widgets para ações na AppBar (ícones, botões)
  final List<Widget>? actionsAppBar;

  // Define se o botão de voltar deve ser exibido
  final bool rollback;

  // Rota opcional para navegação ao clicar no botão de voltar
  final String? route;

  // Título exibido na AppBar
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
    centerTitle: true, // Título centralizado
    leading: rollback
        ? IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (route != null) {
          // Substitui a rota atual por uma nova, se fornecida
          Navigator.of(context).pushReplacementNamed(route!);
        } else {
          // Caso contrário, apenas volta à tela anterior
          Navigator.of(context).pop();
        }
      },
    )
        : null, // Sem botão de voltar se rollback = false
    actions: actionsAppBar, // Ações personalizadas
  );

  // Define altura padrão da AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
