# Network Menu

## Descrição
A **Network Menu** é a tela responsável por gerenciar e adicionar redes no aplicativo. Ela permite selecionar diferentes tipos de rede (Bluetooth, HTTP, MQTT) e configura o estado inicial de cada conexão. É modular e adaptável, servindo como hub para configurar conexões externas.

## Funcionalidades

1. **Seleção de Tipo de Rede**
    - Exibe os tipos de rede disponíveis em uma barra horizontal (`RowNetworkTypeWidget`).
    - Tipos suportados: Bluetooth, HTTP, MQTT.
    - O usuário pode alternar entre os tipos, e a tela atualiza dinamicamente.

2. **Gerenciamento de Bluetooth**
    - Inicializa o Bluetooth apenas uma vez.
    - Atualiza a lista de dispositivos pareados.
    - Mostra botão para ativar Bluetooth caso não esteja disponível.
    - Exibe feedback em caso de erro na inicialização ou atualização.

3. **Integração com Views Específicas**
    - Para o tipo Bluetooth, mostra a `BluetoothView` quando tudo está pronto.
    - Para outros tipos (HTTP, MQTT), exibe texto "Em construção" até implementação futura.

4. **Animação de Transição**
    - Mudança entre tipos de rede é animada com slide e fade usando `flutter_animate`.
    - A direção do slide depende da navegação (esquerda/direita).

## Estrutura de Arquivos

- **network_menu.dart**: Tela principal de adição e gerenciamento de redes.
- **widgets/row_network_type_widget.dart**: Barra horizontal de seleção do tipo de rede.
- **bluetooth/bluetooth_view.dart**: Tela específica de gerenciamento Bluetooth.
- **bluetooth/bluetooth_model_view.dart**: Lógica de estado e conexão Bluetooth.

## Dependências

- `flutter/material.dart`: Componentes básicos do Flutter.
- `signals_flutter`: Observação de sinais para atualizar a UI dinamicamente.
- `provider`: Gerenciamento de estado do BluetoothModelView.
- `flutter_animate`: Animações de transição entre tipos de rede.

## Observações
- Inicialização de Bluetooth é feita apenas uma vez para otimizar desempenho.
- Tela modular que facilita a adição de novos tipos de rede no futuro.
- Feedback visual e notificações ajudam o usuário a acompanhar o estado da rede.
