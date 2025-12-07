/*
--------------------------------------------
Arquivo: connection_status_row.dart
Descrição: Widget para exibir o status de conexão de um dispositivo.
           Mostra protocolo, nome do dispositivo, endereço opcional
           e ícone indicando se está conectado ou desconectado.
Autor: Isac Eugenio
--------------------------------------------
*/

import 'package:flutter/material.dart';

class ConnectionStatusRow extends StatelessWidget {
  final String deviceName;
  final String? address;
  final bool state; // true = conectado, false = desconectado
  final String protocolName; // Ex.: "Wi-Fi" ou "BLE"
  final IconData protocolIcon; // Ícone do protocolo

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
      color: Colors.grey.shade100, // fundo leve
      child: Row(
        children: [
          /// Esquerda: ícone do protocolo + nome
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

          const Spacer(), // espaço flexível

          /// Centro/Direita: nome do dispositivo + endereço (opcional)
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

          /// Status visual: círculo verde se conectado, vermelho se desconectado
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
