import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/shared/cases/bluetooth_case.dart';
import 'package:lablinker/app/shared/widgets/notification_widget.dart';
import 'package:provider/provider.dart';

class BluetoothView extends StatelessWidget {
  const BluetoothView({super.key});

  @override
  Widget build(BuildContext context) {
    BluetoothCase bluetooth = Provider.of<BluetoothCase>(context);
    List<BluetoothDevice> devices = bluetooth.getPairedDevices;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: ListView.builder(
          itemCount: bluetooth.getPairedDevices.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            BluetoothDevice device = devices[index];
            return ListTile(
              leading: const Icon(Icons.bluetooth),
              title: Text(device.name),
              subtitle: Text(device.address),
              trailing: bluetooth.getConnectedDevice?.address == device.address
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () async {
                var deviceConnect = await bluetooth.connectToDevice(device);
                 if(deviceConnect.isSuccess && bluetooth.getConnectedDevice != null){
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
