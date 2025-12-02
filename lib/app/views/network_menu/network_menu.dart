import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lablinker/app/shared/commands/result.dart';
import 'package:lablinker/app/shared/widgets/notification_widget.dart';
import 'package:lablinker/app/views/base_view.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_model_view.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_view.dart';
import 'package:lablinker/app/views/network_menu/widgets/row_network_type_widget.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

class NetworkMenu extends BaseView {
  const NetworkMenu({super.key})
    : super(
        title: "Adicionar Rede",
        rollback: false,
        floatingActionButtonVisible: true,
        floatingActionButtonIcon: Icons.save,
        floatingActionButtonOnPressed: null,
      );

  @override
  BaseViewState<BaseView> createState() => NetworkMenuState();
}

class NetworkMenuState extends BaseViewState<NetworkMenu> {
  late BluetoothModelView bluetoothModel;

  final indexSignal = signal(0);
  int previousIndex = 0;

  Future<Result>? _initBluetoothFuture;

  Future<Result> _initializeBluetoothOnce() async {
    // Se já inicializou antes, apenas atualiza a lista
    if (_initBluetoothFuture != null) {
      return bluetoothModel.updatePairedDevices();
    }

    // Caso contrário, inicializa o Bluetooth e guarda o Future
    _initBluetoothFuture = bluetoothModel.initializeBluetooth();
    return _initBluetoothFuture!;
  }

  @override
  Widget buildBody(BuildContext context) {
    bluetoothModel = Provider.of<BluetoothModelView>(context);

    final index = indexSignal.watch(context);
    final direction = (index - previousIndex).sign;
    previousIndex = index;

    Widget view;

    switch (index) {
      case 0:

      // 1️⃣ Bluetooth ainda não inicializado → mostrar botão
        if (!bluetoothModel.isBluetoothAvailable) {
          view = Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.bluetooth),
              label: const Text("Ativar Bluetooth"),
              onPressed: () async {
                final result = await _initializeBluetoothOnce();

                if (result.isFailure) {
                  NotificationWidget(
                    context: context,
                    message: "Erro ao inicializar: ${result.failureOrNull}",
                    durationSeconds: 3,
                  );
                }

                setState(() {}); // Atualiza a tela
              },
            ),
          );
          break; // <- ESSENCIAL
        }

        // 2️⃣ Bluetooth ok mas sem pareados
        if (bluetoothModel.pairedDevices.isEmpty) {
          view = Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Nenhum dispositivo pareado",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await bluetoothModel.updatePairedDevices();
                    setState(() {});
                  },
                  child: const Text("Atualizar lista"),
                ),
              ],
            ),
          );
          break; // <- ESSENCIAL
        }

        // 3️⃣ Tudo pronto → mostra o BluetoothView
        view = const BluetoothView();
        break;


      default:
        view = const Center(child: Text("Em construção"));
    }

    final animatedView = view
        .animate(key: ValueKey(index))
        .slideX(
          begin: direction > 0 ? 1.0 : -1.0,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        )
        .fadeIn(duration: 400.ms);

    return SafeArea(
      child: Column(
        children: [
          RowNetworkTypeWidget(indexSignal: indexSignal),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: animatedView,
            ),
          ),
        ],
      ),
    );
  }
}
