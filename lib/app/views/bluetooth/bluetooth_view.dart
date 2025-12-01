import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/shared/widgets/notification_widget.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_model_view.dart';
import 'package:provider/provider.dart';

class BluetoothView extends StatelessWidget {
  const BluetoothView({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetooth = Provider.of<BluetoothModelView>(context);
    final theme = Theme.of(context);

    final List<BluetoothDevice> devices = bluetooth.state.pairedDevices;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          /// Botão Atualizar
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text("Atualizar dispositivos"),
              onPressed: () async {
                await bluetooth.updatePairedDevices();
              },
            ),
          ),

          const SizedBox(height: 20),

          /// Card com a lista
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
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// LISTA COM LISTTILE
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
                                var result = await bluetooth.connectToDevice(device);

                                if (result.isSuccess &&
                                    bluetooth.state.connectedDevice != null) {
                                  NotificationWidget(
                                    context: context,
                                    message: "Conectado: ${device.name}",
                                    durationSeconds: 2,
                                  );
                                }
                              },
                              child: Card(
                                elevation: 4,
                                color: Colors.blue.shade500,
                                shadowColor: Colors.black26,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  leading: Icon(
                                    Icons.bluetooth,
                                    size: 30,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  title: Text(
                                    device.name,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      decorationColor: Colors.black87
                                    )
                                  ),
                                  subtitle: Text(
                                    device.address,
                                    style: theme.textTheme.bodySmall
                                  ),
                                  trailing: (bluetooth.state.connectedDevice?.address ==
                                      device.address)
                                      ? const Icon(Icons.check, color: Colors.green, size: 28)
                                      : null,

                                  style: Theme.of(context).listTileTheme.style
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
