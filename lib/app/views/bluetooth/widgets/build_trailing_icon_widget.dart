import 'package:flutter/material.dart';

// Este enum rastreia o estado visual do dispositivo na lista
enum StateTrailing {
  none,       // Nada sendo exibido (estado inicial/desconectado)
  connecting, // Indicador de progresso (em tentativa de conexão)
  connected,  // Ícone de sucesso (conexão estabelecida)
}

class BuildTrailingIconWidget extends StatelessWidget {
  final String currentDeviceAddress;
  final String targetDeviceAddress;
  final StateTrailing connectionState;

  const BuildTrailingIconWidget({
    super.key,
    required this.currentDeviceAddress,
    required this.targetDeviceAddress,
    required this.connectionState,
  });

  @override
  Widget build(BuildContext context) {

    // 1. Verifica se o endereço do dispositivo atual é o mesmo do dispositivo desejado/pressionado.
    if (currentDeviceAddress != targetDeviceAddress) {
      // Se não for o dispositivo correto, retorna um espaço vazio (SizedBox de tamanho zero).
      return const SizedBox(width: 0, height: 0);
    }

    // 2. Se os endereços forem iguais, exibe o ícone de acordo com o estado.
    switch (connectionState) {
      case StateTrailing.connecting:
      // Indicador de progresso circular para mostrar que a conexão está em andamento
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        );

      case StateTrailing.connected:
      // Ícone verde de check para indicar sucesso na conexão
        return const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 28
        );

      case StateTrailing.none:
      // Mesmo que os endereços batam, se o estado for 'none', retorna vazio.
        return const SizedBox(width: 0, height: 0);
    }
  }
}