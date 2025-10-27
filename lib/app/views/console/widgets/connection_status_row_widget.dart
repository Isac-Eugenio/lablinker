import 'package:flutter/material.dart';

class ConnectionStatusRow extends StatelessWidget {
  final String deviceName;
  final String? address;
  final bool state; // true = conectado, false = desconectado
  final String protocolName; // exemplo: "Wi-Fi" ou "BLE"
  final IconData protocolIcon; // ícone do protocolo

  const ConnectionStatusRow({
    super.key,
    required this.deviceName,
    this.address,
    required this.state,
    required this.protocolName,
    required this.protocolIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          // Esquerda: ícone do protocolo + nome
          Row(
            children: [
              Icon(protocolIcon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                protocolName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),

          const Spacer(), // espaço entre esquerda e direita

          // Centro/Direita: device + address
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                deviceName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (address != null)
                Text(
                  address!,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
            ],
          ),

          const SizedBox(width: 12),

          // Ícone de estado tipo LED
          Icon(
            Icons.circle,
            color: state ? Colors.green : Colors.red,
            size: 16,
          ),
        ],
      ),
    );
  }
}
