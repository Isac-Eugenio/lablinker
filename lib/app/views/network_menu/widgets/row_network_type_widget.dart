import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class RowNetworkTypeWidget extends StatelessWidget {
  final List<String> networkTypes = const ["Bluetooth", "HTTP", "MQTT"];
  final Signal<int> indexSignal;

  const RowNetworkTypeWidget({super.key, required this.indexSignal});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.white,
        );

    // Agora o widget vai se reconstruir automaticamente
    // sempre que indexSignal mudar:
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
                    onTap: () => indexSignal.value = index, // Atualiza o signal
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
