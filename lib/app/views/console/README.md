# Console View

## Descrição
A **Console View** é a interface principal para interagir com dispositivos conectados via Bluetooth. Ela funciona como um terminal, permitindo que o usuário:

- Visualize o estado da conexão com o dispositivo.
- Envie comandos diretamente ao dispositivo.
- Receba e exiba mensagens do dispositivo em tempo real.
- Limpe o histórico de mensagens.
- Reconecte-se automaticamente ao último dispositivo conectado.

Faz parte da arquitetura modular do aplicativo, sendo independente e reutilizável.

## Funcionalidades

1. **Status da Conexão**
    - Mostra nome e endereço do dispositivo conectado.
    - Indica se a conexão está ativa ou não.

2. **Envio de Comandos**
    - Campo de texto para digitar comandos.
    - Botão de envio ou envio ao pressionar Enter.
    - Suporte a envio de múltiplos comandos em sequência.

3. **Recebimento de Mensagens**
    - Mensagens do dispositivo exibidas à esquerda.
    - Mensagens do usuário exibidas à direita.
    - Histórico mantido até que seja limpo manualmente.

4. **Reconexão Automática**
    - Reconecta ao último dispositivo conectado via long press.
    - Mostra feedback visual durante o processo.

5. **Integração com o Modelo**
    - Usa `ConsoleModelview` para lógica de conexão, envio e recebimento de mensagens.
    - Observa alterações de estado usando `Signal` e `ChangeNotifier`.

## Estrutura de Arquivos

- **console_view.dart**: Tela principal do console.
- **console_modelview.dart**: Lógica de conexão, envio e recebimento de mensagens.
- **widgets/**
    - `connection_status_row_widget.dart`: Exibe status de conexão.
    - `message_bubble_widget.dart`: Componente de bolha para mensagens.

## Dependências

- `flutter_bluetooth_classic_serial`: Comunicação Bluetooth Classic.
- `signals_flutter`: Observação de sinais e atualização da UI.
- `provider`: Gerenciamento de estado do BluetoothModelView.

## Observações
- Todo envio e recebimento de mensagens é assíncrono.
- A view depende fortemente de `ConsoleModelview`.
- Permite integração com outras views e módulos do aplicativo.
