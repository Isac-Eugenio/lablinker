import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/communication/bluetooth/bluetooth_menu__model_view.dart';
import 'package:lablinker/app/shared/communication/bluetooth/bluetooth_model_view.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/views/base_view.dart';
import 'package:provider/provider.dart';

import 'bluetooth_case.dart';

class BluetoothMenuView extends BaseView {
  BluetoothMenuView({super.key, required super.title})
    : super(rollback: true, route: Routes.protocolsRoute.path);

  @override
  BaseViewState<BaseView> createState() => BluetoothMenuViewState();
}

class BluetoothMenuViewState extends BaseViewState {
  late BluetoothMenuModelView model;

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

    Future.microtask(() => model.init());
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

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Bloco 1 - Botão
          ElevatedButton.icon(
            onPressed: () {
              model.update();
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Atualizar lista"),
          ),

          const SizedBox(height: 16),

          // Bloco 2 - Card com lista
          Expanded(
            child: Card(
              elevation: 2,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: model.devicePaired?.length ?? 0,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final device = model.devicePaired?[index];

                  return ListTile(
                    leading: const Icon(Icons.bluetooth),
                    title: Text(device?.name ?? "Dispositivo sem nome"),
                    subtitle: Text(device?.address ?? ""),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Conectar ao dispositivo
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
