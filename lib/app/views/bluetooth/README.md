# Bluetooth View

## Descrição
A **Bluetooth View** é responsável por gerenciar a comunicação entre o aplicativo e dispositivos Bluetooth Classic. Ela fornece uma interface para:

- Visualizar o estado atual da conexão Bluetooth.
- Enviar comandos para dispositivos conectados.
- Exibir mensagens recebidas do dispositivo.
- Reconectar automaticamente ao último dispositivo conectado.
- Limpar e gerenciar o histórico de mensagens.

Esta view faz parte da arquitetura de **páginas modulares** do aplicativo, permitindo que cada view seja independente e reutilizável.

## Funcionalidades

1. **Status da Conexão**
    - Mostra o nome do dispositivo conectado ou "Desconectado".
    - Indica visualmente se a conexão está ativa.

2. **Envio de Comandos**
    - Campo de entrada para digitar comandos.
    - Botão para enviar comandos ao dispositivo conectado.

3. **Recebimento de Mensagens**
    - Mostra mensagens recebidas alinhadas à esquerda (dispositivo) ou direita (usuário).
    - Mantém histórico de mensagens até que seja limpo manualmente.

4. **Reconexão Automática**
    - Reconecta ao último dispositivo ao pressionar prolongadamente.
    - Indica visualmente quando está reconectando.

5. **Integração com o Modelo**
    - Usa `ConsoleModelview` para lógica de negócios.
    - Observa alterações de estado usando `Signal` e `ChangeNotifier`.

## Estrutura de Arquivos

- **console_view.dart**: Interface principal da tela do console Bluetooth.
- **console_modelview.dart**: Model que gerencia estado, envio/recebimento de mensagens e conexão.
- **widgets/**
    - `connection_status_row_widget.dart`: Mostra estado da conexão.
    - `message_bubble_widget.dart`: Componente de bolha de mensagem.

## Dependências

- `flutter_bluetooth_classic_serial`: Comunicação Bluetooth Classic.
- `signals_flutter`: Observação de sinais para reconexão e UI.
- `provider`: Gerenciamento de estado do BluetoothModelView.

## Observações
- A view é altamente dependente do `BluetoothModelView`.
- Todo envio/recebimento de mensagens é assíncrono.
- Permite integração fácil com outras views do aplicativo (IOT, Consoles, Configurações).
