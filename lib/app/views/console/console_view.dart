import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/widgets/notification_widget.dart';
import 'package:lablinker/app/views/base_view.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_model_view.dart';
import 'package:lablinker/app/views/console/console_modelview.dart';
import 'package:lablinker/app/views/console/widgets/connection_status_row_widget.dart';
import 'package:lablinker/app/views/console/widgets/message_bubble_widget.dart';
import 'package:lablinker/app/views/network_menu/widgets/add_network_widget.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

class ConsoleView extends BaseView {
  ConsoleView({super.key})
    : super(
        title: "Console",
        rollback: true,
        route: Routes.home,
        actionsAppBar: [AddNetworkWidget(routeRollback: Routes.consoles)],
      );

  @override
  BaseViewState<BaseView> createState() => ConsoleViewState();
}

class ConsoleViewState extends BaseViewState<BaseView> {
  late ConsoleModelview modelview;
  late VoidCallback _listener;

  // 💡 CORREÇÃO: Usamos Signal<bool> para o estado de loading.
  final isReconnecting = signal(false);

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (!mounted) return;
      setState(() {});
    };

    final bluetooth = Provider.of<BluetoothModelView>(context, listen: false);

    bluetooth.addListener(_listener);

    modelview = ConsoleModelview(bluetooth, context);

    modelview.addListener(_listener);
  }

  @override
  void dispose() {
    modelview.bluetooth.removeListener(_listener);
    modelview.clearMessages();
    modelview.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    // 💡 CHAVE DA CORREÇÃO: Observar o Signal. Isso força a reconstrução quando isReconnecting muda.
    final isLoading = isReconnecting.watch(context);

    final bluetoothState = modelview.bluetooth.state;

    return Column(
      children: [
        InkWell(
          onTap: () async {
            await modelview.bluetooth.disconnectDevice();
            NotificationWidget(
              context: context,
              message:
                  "Desconectando do dispositivo ${modelview.bluetooth.connectedDevice?.name}",
              durationSeconds: 2,
            );
          },
          onLongPress: () async {
            BluetoothDevice? lastDevice = bluetoothState.lastConnectedDevice;

            if (lastDevice == null) {
              NotificationWidget(
                context: context,
                message: "Nenhum dispositivo anterior encontrado.",
                durationSeconds: 2,
              );
              return;
            }

            // 1. Ativa o loading
            isReconnecting.value = true;

            // 2. Inicia a reconexão (Método corrigido: connectToDevice)
            // Se o seu BluetoothCase usa 'initiateConnection', mantenha. Se usa 'connectToDevice', use 'connectToDevice'.
            var result = await modelview.bluetooth.initiateConnection(
              lastDevice,
            );

            // 3. Desativa o loading
            isReconnecting.value = false;

            // 4. Exibe o resultado
            NotificationWidget(
              context: context,
              message: result.isSuccess
                  ? "Reconectado a ${lastDevice.name}"
                  : "Erro ao se reconectar em ${lastDevice.name}",
              // Corrigido o erro de digitação no feedback
              durationSeconds: 3,
            );
          },
          child: ConnectionStatusRow(
            deviceName: bluetoothState.connectedDevice?.name ?? "Desconectado",
            address: bluetoothState.connectedDevice?.address,
            state: bluetoothState.connectionState?.isConnected ?? false,
            protocolName: "Bluetooth",
            protocolIcon: Icons.bluetooth,
          ),
        ),

        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            controller: modelview.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            // 💡 CORREÇÃO CRÍTICA: Lógica de exibição e tipo do 'children'
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: modelview.messages
                        .map(
                          (msg) => Align(
                            alignment: msg.isUser
                                ? Alignment
                                      .centerRight // 👉 minhas mensagens à direita
                                : Alignment.centerLeft, // 👉 cliente à esquerda
                            child: MessageBubbleWidget(
                              text: msg.text,
                              isUser: msg.isUser,
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ),

        // Campo de entrada fixo (mantido sem alterações)
        SafeArea(
          bottom: true,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.clear_all),
                  onPressed: () => modelview.clearMessages(),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: TextField(
                    controller: modelview.commandController,
                    obscureText: false,
                    enableSuggestions: true,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: "Digite um comando...",
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      color:
                          Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0,
                    ),
                    onSubmitted: modelview.sendCommand,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () =>
                      modelview.sendCommand(modelview.commandController.text),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
