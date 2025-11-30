import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/shared/widgets/notification_widget.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_model_view.dart';
import 'package:provider/provider.dart';

class BluetoothView extends StatelessWidget {
  const BluetoothView({super.key});

  @override
  Widget build(BuildContext context) {

    BluetoothModelView bluetooth = Provider.of<BluetoothModelView>(context);

    List<BluetoothDevice> devices = bluetooth.state.pairedDevices;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: ListView.builder(
          itemCount: bluetooth.state.pairedDevices.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            BluetoothDevice device = devices[index];
            return ListTile(
              leading: const Icon(Icons.bluetooth),
              title: Text(device.name),
              subtitle: Text(device.address),
              trailing: bluetooth.state.connectedDevice?.address == device.address
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () async {
                var deviceConnect = await bluetooth.connectToDevice(device);
                 if(deviceConnect.isSuccess && bluetooth.state.connectedDevice != null){
                  // ignore: use_build_context_synchronously
                  NotificationWidget(context: context,
                    message: 'Dispositivo conectado: ${device.name}',
                    durationSeconds: 2
                  );
                 }
              },
            );
          },
        ),
      ),
    );
  }
}
