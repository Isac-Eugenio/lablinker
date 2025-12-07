/*
--------------------------------------------
Arquivo: bluetooth_view.dart
Descrição: Tela de gerenciamento de Bluetooth.
           Permite listar dispositivos pareados,
           iniciar conexão, e mostrar status de UI
           via ícones (loading, conectado, nenhum).
Autor: Isac Eugenio
--------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/shared/widgets/notification_widget.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_model_view.dart';
import 'package:lablinker/app/views/bluetooth/widgets/build_trailing_icon_widget.dart';
import 'package:provider/provider.dart';

class BluetoothView extends StatelessWidget {
  const BluetoothView({super.key});

  @override
  Widget build(BuildContext context) {
    // Acesso ao ViewModel
    final bluetooth = Provider.of<BluetoothModelView>(context);
    final theme = Theme.of(context);

    final List<BluetoothDevice> devices = bluetooth.state.pairedDevices;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          /// Botão Atualizar dispositivos
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text("Atualizar dispositivos"),
              onPressed: () async {
                debugPrint(bluetooth.connectionState?.isConnected.toString());
                await bluetooth.updatePairedDevices();
              },
            ),
          ),

          const SizedBox(height: 20),

          /// Card contendo a lista de dispositivos
          Expanded(
            child: Card(
              elevation: 4,
              color: Colors.blue.shade600,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.white, width: 3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Dispositivos Pareados",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Lista de dispositivos
                    Expanded(
                      child: ListView.builder(
                        itemCount: devices.length,
                        itemBuilder: (BuildContext context, int index) {
                          final device = devices[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () async {
                                // Inicia conexão via ViewModel
                                final connectionFuture = bluetooth.initiateConnection(device);

                                connectionFuture.then((result) {
                                  // Mostra notificações dependendo do resultado
                                  if (result.isFailure) {
                                    NotificationWidget(
                                      context: context,
                                      message: "Erro ao Conectar ao Dispositivo ${device.name}",
                                      durationSeconds: 2,
                                    );
                                  } else {
                                    NotificationWidget(
                                      context: context,
                                      message: "Conectado ao Dispositivo ${device.name}",
                                      durationSeconds: 2,
                                    );
                                  }
                                });
                              },

                              child: Card(
                                elevation: 4,
                                color: Colors.blue.shade500,
                                shadowColor: Colors.black26,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(color: Colors.white, width: 1.5),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  leading: Icon(
                                    Icons.bluetooth,
                                    size: 30,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  title: Text(
                                    device.name,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    device.address,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  // Ícone do estado de conexão (loading, conectado, none)
                                  trailing: BuildTrailingIconWidget(
                                    currentDeviceAddress: device.address,
                                    targetDeviceAddress: bluetooth.targetAddress,
                                    connectionState: bluetooth.getStateTrailing,
                                  ),
                                  style: theme.listTileTheme.style,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
