import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/communication/bluetooth/bluetooth_menu_model_view.dart';
import 'package:lablinker/app/shared/routes/route_context.dart';
import 'package:lablinker/app/shared/widgets/base_view.dart';
import 'package:provider/provider.dart';

import 'bluetooth_case.dart';

class BluetoothMenuView extends BaseView {
  BluetoothMenuView({super.key, required super.title})
    : super(rollback: false, route: RouteContext.previousRoute.value?.path);

  @override
  BaseViewState<BaseView> createState() => BluetoothMenuViewState();
}

class BluetoothMenuViewState extends BaseViewState {
  late BluetoothMenuModelView model;

  late bool isConnected;

  void _onModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    model = BluetoothMenuModelView(context.read<BluetoothCase>());

    model.addListener(_onModelChanged);

    Future.microtask(
      () => Future.microtask(
        () => model.bluetoothCase.value.isAvailable ? () {} : model.init(),
      ),
    );
  }

  @override
  void dispose() {
    model.removeListener(_onModelChanged);
    model.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    if (!model.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Bloco 1 - Botão
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: ElevatedButton.icon(
              onPressed: () {
                model.update();
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Atualizar lista"),
            ),
          ),

          // Bloco 2 - Card com lista
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Card(
                elevation: 2,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: model.devicePaired?.length ?? 0,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final device = model.devicePaired?[index];

                    return (device == null)
                        ? ListTile(
                            title: Text("Dispositivo sem nome"),
                            subtitle: Text(""),
                          )
                        : ListTile(
                            leading:
                                model.isConnectingDevice(device) ||
                                    model.isDisconnectingDevice(device)
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Icon(
                                    Icons.bluetooth,
                                    color: model.isConnected(device)
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                            title: Text(device.name),
                            subtitle: Text(device.address),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => model.toggleConnection(device),
                          );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
