/*
------------------------------------
Arquivo: build_trailing_icon_widget.dart
Descrição: Widget que exibe ícone ou indicador de conexão para cada dispositivo na lista
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';

// Enum que representa o estado visual do dispositivo na lista
enum StateTrailing {
  none,       // Nada sendo exibido (desconectado ou inicial)
  connecting, // Mostra indicador de progresso
  connected,  // Mostra ícone de sucesso
}

class BuildTrailingIconWidget extends StatelessWidget {
  // Endereço do dispositivo atualmente processado
  final String currentDeviceAddress;

  // Endereço do dispositivo alvo que deve exibir o ícone
  final String targetDeviceAddress;

  // Estado atual da conexão do dispositivo
  final StateTrailing connectionState;

  const BuildTrailingIconWidget({
    super.key,
    required this.currentDeviceAddress,
    required this.targetDeviceAddress,
    required this.connectionState,
  });

  @override
  Widget build(BuildContext context) {

    // 1. Verifica se o dispositivo atual é o alvo
    if (currentDeviceAddress != targetDeviceAddress) {
      // Se não for, retorna um widget vazio
      return const SizedBox(width: 0, height: 0);
    }

    // 2. Exibe o ícone correspondente ao estado
    switch (connectionState) {
      case StateTrailing.connecting:
      // Indicador de progresso circular para conexão em andamento
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );

      case StateTrailing.connected:
      // Ícone verde de sucesso quando conectado
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 28,
        );

      case StateTrailing.none:
      // Nenhum ícone se o estado for 'none'
        return const SizedBox(width: 0, height: 0);
    }
  }
}
