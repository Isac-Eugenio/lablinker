// /*
// -----------------------------------------------------------
// Arquivo: console_view.dart
// Descrição: Tela de console para comunicação via Bluetooth.
//            Permite conectar, desconectar e enviar comandos
//            a dispositivos Bluetooth. Exibe histórico de mensagens
//            com distinção entre usuário e dispositivo.
// Autor: Isac Eugenio
// -----------------------------------------------------------
// */

// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
// import 'package:lablinker/app/shared/routes/routes.dart';
// import 'package:lablinker/app/shared/widgets/notification_widget.dart';
// import 'package:lablinker/app/views/base_view.dart';
// import 'package:lablinker/app/views/bluetooth/bluetooth_model_view.dart';
// import 'package:lablinker/app/views/console/console_modelview.dart';
// import 'package:lablinker/app/views/console/widgets/connection_status_row_widget.dart';
// import 'package:lablinker/app/views/console/widgets/message_bubble_widget.dart';
// import 'package:lablinker/app/views/network_menu/widgets/add_network_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:signals/signals_flutter.dart';

// class ConsoleView extends BaseView {
//   ConsoleView({super.key})
//       : super(
//     title: "Console",
//     rollback: true, // Permite voltar para rota anterior
//     route: Routes.homeRoute.path, // Rota padrão
//     actionsAppBar: [AddNetworkWidget(routeRollback: Routes.homeRoute.path)], // Ação na AppBar
//   );

//   @override
//   BaseViewState<BaseView> createState() => ConsoleViewState();
// }

// class ConsoleViewState extends BaseViewState<BaseView> {
//   late ConsoleModelview modelview; // Gerencia lógica de mensagens e Bluetooth
//   late VoidCallback _listener; // Listener para atualizar a UI

//   final isReconnecting = signal(false); // Estado de reconexão

//   @override
//   void initState() {
//     super.initState();
//     _listener = () {
//       if (!mounted) return;
//       setState(() {}); // Atualiza a UI
//     };

//     final bluetooth = Provider.of<BluetoothModelView>(context, listen: false);

//     bluetooth.addListener(_listener); // Atualiza quando Bluetooth muda

//     modelview = ConsoleModelview(bluetooth, context);

//     modelview.addListener(_listener); // Atualiza quando mensagens mudam
//   }

//   @override
//   void dispose() {
//     modelview.bluetooth.removeListener(_listener); // Remove listener
//     modelview.clearMessages(); // Limpa mensagens ao sair
//     modelview.dispose(); // Limpa recursos
//     super.dispose();
//   }

//   @override
//   Widget buildBody(BuildContext context) {
//     final isLoading = isReconnecting.watch(context); // Observa reconexão
//     final bluetoothState = modelview.bluetooth.state;

//     return Column(
//       children: [
//         // Linha de status do dispositivo Bluetooth
//         InkWell(
//           onTap: () async {
//             // Desconecta do dispositivo atual
//             var r = modelview.bluetooth.disconnectDevice();
//             NotificationWidget(
//               context: context,
//               message:
//               "Desconectando do dispositivo ${modelview.bluetoothState.lastConnectedDevice?.name}",
//               durationSeconds: 2,
//             );

//             r.then((v) {
//               (v.isSuccess ?? false)
//                   ? NotificationWidget(
//                 context: context,
//                 message:
//                 "Desconectado do dispositivo ${modelview.bluetoothState.lastConnectedDevice?.name}",
//                 durationSeconds: 2,
//               )
//                   : NotificationWidget(
//                 context: context,
//                 message: v.value.toString(),
//                 durationSeconds: 2,
//               );
//             });
//           },
//           onLongPress: () async {
//             // Reconecta ao último dispositivo
//             BluetoothDevice? lastDevice = bluetoothState.lastConnectedDevice;

//             if (lastDevice == null) {
//               NotificationWidget(
//                 context: context,
//                 message: "Nenhum dispositivo anterior encontrado.",
//                 durationSeconds: 2,
//               );
//               return;
//             }

//             isReconnecting.value = true; // Ativa loading

//             var result = await modelview.bluetooth.initiateConnection(
//               lastDevice,
//             );

//             isReconnecting.value = false; // Desativa loading

//             NotificationWidget(
//               context: context,
//               message: result.isSuccess
//                   ? "Reconectado a ${lastDevice.name}"
//                   : "Erro ao se reconectar em ${lastDevice.name}",
//               durationSeconds: 3,
//             );
//           },
//           child: ConnectionStatusRow(
//             deviceName: bluetoothState.connectedDevice?.name ?? "Desconectado",
//             address: bluetoothState.connectedDevice?.address,
//             state: bluetoothState.connectionState?.isConnected ?? false,
//             protocolName: "Bluetooth",
//             protocolIcon: Icons.bluetooth,
//           ),
//         ),

//         const SizedBox(height: 8),

//         // Área de mensagens
//         Expanded(
//           child: SingleChildScrollView(
//             controller: modelview.scrollController,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator()) // Loading durante reconexão
//                 : Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: modelview.messages
//                   .map(
//                     (msg) => Align(
//                   alignment: msg.isUser
//                       ? Alignment.centerRight // Mensagens do usuário
//                       : Alignment.centerLeft, // Mensagens do dispositivo
//                   child: MessageBubbleWidget(
//                     text: msg.text,
//                     isUser: msg.isUser,
//                     deviceName: modelview.bluetoothState.lastConnectedDevice?.name ??
//                         'desconhecido',
//                   ),
//                 ),
//               )
//                   .toList(),
//             ),
//           ),
//         ),

//         // Campo de entrada de comando
//         SafeArea(
//           bottom: true,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             color: Theme.of(context).cardColor,
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.clear_all),
//                   onPressed: () => modelview.clearMessages(), // Limpa mensagens
//                 ),
//                 const SizedBox(width: 4),
//                 Expanded(
//                   child: TextField(
//                     controller: modelview.commandController,
//                     obscureText: false,
//                     enableSuggestions: true,
//                     autocorrect: false,
//                     decoration: const InputDecoration(
//                       hintText: "Digite um comando...",
//                       border: OutlineInputBorder(),
//                     ),
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: 'Roboto',
//                       letterSpacing: 0,
//                     ),
//                     onSubmitted: modelview.sendCommand, // Envia ao pressionar Enter
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () =>
//                       modelview.sendCommand(modelview.commandController.text), // Envia via botão
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
