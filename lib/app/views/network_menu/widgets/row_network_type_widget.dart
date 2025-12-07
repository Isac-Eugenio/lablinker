/*
-----------------------------------------------------------
Arquivo: row_network_type_widget.dart
Descrição: Widget que exibe tipos de rede (Bluetooth, HTTP, MQTT)
           em uma linha horizontal. O item selecionado é destacado
           e atualiza automaticamente via Signal<int>.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class RowNetworkTypeWidget extends StatelessWidget {
  final List<String> networkTypes = const ["Bluetooth", "HTTP", "MQTT"];
  final Signal<int> indexSignal; // Índice selecionado monitorado por Signal

  const RowNetworkTypeWidget({super.key, required this.indexSignal});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
      color: Colors.white,
    );

    // Observa mudanças no Signal para reconstruir o widget
    final selectedIndex = indexSignal.watch(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF1976D2),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: networkTypes.length,
                itemBuilder: (context, index) {
                  final isSelected = index == selectedIndex;

                  return GestureDetector(
                    onTap: () => indexSignal.value = index, // Atualiza seleção
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue.shade900
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        networkTypes[index],
                        style: textStyle?.copyWith(
                          fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
