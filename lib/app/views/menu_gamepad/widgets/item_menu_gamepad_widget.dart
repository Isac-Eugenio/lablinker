import 'package:flutter/material.dart';

import '../../../models/protocol_model.dart';
import '../../../shared/modelviews/page_navigator_viewmodel.dart';
import '../../../shared/routes/routes.dart';

class ItemMenuGamepadWidget extends StatelessWidget {
  final String? title;
  final String subtitle;
  final IconData icon = Icons.gamepad_outlined;
  final ProtocolsEnum protocol;
  final int index;

  const ItemMenuGamepadWidget({
    super.key,
    this.title,
    required this.subtitle,
    required this.protocol,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Dismissible(
        key: ValueKey(title),
        background: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.white,
          child: const Row(
            children: [
              Icon(Icons.edit, color: Colors.grey, size: 40),
              SizedBox(width: 8),
              Text(
                "Editar",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.red,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Deletar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(width: 8),
              Icon(Icons.delete, color: Colors.white, size: 40),
            ],
          ),
        ),
        confirmDismiss: (direction) async {
          direction == DismissDirection.startToEnd
              ? pageNavigatorViewModel.go(RoutesName.menuGamepad, context)
              : pageNavigatorViewModel.go(RoutesName.menuGamepad, context);
          return false;
        },
        child: SizedBox(
          height: 110, // aumenta a altura total do card
          child: Card(
            elevation: 1,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ), // aumenta o espaçamento interno
              style: ListTileStyle.drawer,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "Gamepad ${index + 1}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(subtitle, style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
              leading: Icon(icon, size: 60), // o ícone não será mais cortado
              trailing: Text(
                protocol.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
