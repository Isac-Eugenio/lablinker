/*
-----------------------------------------------------------
Arquivo: item_page_widget.dart
Descrição: Widget de item de menu exibido em grid.
           Mostra ícone e título, e navega para rota definida ao toque.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';

class ItemPageWidget extends StatelessWidget {
  final String title; // Título do item
  final IconData icon; // Ícone do item
  final String? route; // Rota de navegação (opcional)

  const ItemPageWidget({
    super.key,
    required this.title,
    required this.icon,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: route == null
          ? null
          : () => Navigator.of(context).pushReplacementNamed(route!), // Navega se rota definida
      child: Card(
        color: Colors.transparent,
        elevation: 3.0,
        shadowColor: Colors.white24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white, width: 1.5), // Borda do card
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48.0, color: Colors.white), // Ícone central
              const SizedBox(height: 12.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
