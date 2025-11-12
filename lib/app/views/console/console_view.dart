import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/cases/bluetooth_case.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/widgets/notification_widget.dart';
import 'package:lablinker/app/views/base_view.dart';
import 'package:lablinker/app/views/console/console_modelview.dart';
import 'package:lablinker/app/views/console/widgets/connection_status_row_widget.dart';
import 'package:lablinker/app/views/console/widgets/message_bubble_widget.dart';
import 'package:lablinker/app/views/network_menu/widgets/add_network_widget.dart';
import 'package:provider/provider.dart';

class ConsoleView extends BaseView {
  ConsoleView({super.key}) /*  */
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

  @override
  void initState() {
    super.initState();

    final bluetooth = Provider.of<BluetoothCase>(context, listen: false);

    modelview = ConsoleModelview(ValueNotifier<BluetoothCase>(bluetooth));
    _listener = () => setState(() {});
    modelview.addListener(_listener);
  }

  @override
  void dispose() {
    modelview.removeListener(_listener); // ✅ remove corretamente
    modelview.clearMessages();
    modelview.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            NotificationWidget(
              context: context,
              message: "teste",
              durationSeconds: 2,
            );
          },
          onLongPress: () {},
          child: ConnectionStatusRow(
            deviceName:
                modelview.bluetooth.value.getConnectedDevice?.name ??
                "Desconectado",
            address: modelview.bluetooth.value.getConnectedDevice?.address,
            state: modelview.bluetooth.value.getConnectedDevice != null
                ? true
                : false,
            protocolName: "Bluetooth",
            protocolIcon: Icons.bluetooth,
          ),
        ),

        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            controller: modelview.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
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

        // Campo de entrada fixo
        SafeArea(
          bottom: true,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.clear_all),
                  onPressed: () => modelview.clearMessages(),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: TextField(
                    controller: modelview.commandController,
                    obscureText: false, // ✅ evita o texto aparecer como “-----”
                    enableSuggestions: true,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: "Digite um comando...",
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      color: Colors.black, // define cor manual
                      fontFamily: 'Roboto', // ou use a mesma fonte do tema
                      letterSpacing: 0, // impede espaçamento estranho
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
