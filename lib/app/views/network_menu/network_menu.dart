/*
-----------------------------------------------------------
Arquivo: network_menu.dart
Descrição: Tela para adicionar rede com seleção entre tipos
           de conexão (Bluetooth, HTTP, MQTT). Gerencia inicialização
           de Bluetooth, atualização de dispositivos pareados e
           navegação entre views animadas.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

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
    floatingActionButtonVisible: true, // Exibe FAB
    floatingActionButtonIcon: Icons.save, // Ícone do FAB
    floatingActionButtonOnPressed: null, // Ação do FAB ainda não definida
  );

  @override
  BaseViewState<BaseView> createState() => NetworkMenuState();
}

class NetworkMenuState extends BaseViewState<NetworkMenu> {
  late BluetoothModelView bluetoothModel; // Model para gerenciar Bluetooth

  final indexSignal = signal(0); // Tipo de rede selecionado
  int previousIndex = 0; // Armazena índice anterior para animação

  Future<Result>? _initBluetoothFuture; // Future único para inicialização

  Future<Result> _initializeBluetoothOnce() async {
    if (_initBluetoothFuture != null) {
      return bluetoothModel.updatePairedDevices(); // Atualiza lista se já inicializou
    }

    _initBluetoothFuture = bluetoothModel.initializeBluetooth(); // Inicializa Bluetooth
    return _initBluetoothFuture!;
  }

  @override
  Widget buildBody(BuildContext context) {
    bluetoothModel = Provider.of<BluetoothModelView>(context);

    final index = indexSignal.watch(context); // Observa index selecionado
    final direction = (index - previousIndex).sign; // Determina direção da animação
    previousIndex = index;

    Widget view;

    switch (index) {
      case 0:
      // 1️⃣ Bluetooth não inicializado → mostra botão de ativar
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
                setState(() {}); // Atualiza tela
              },
            ),
          );
          break;
        }

        // 2️⃣ Bluetooth disponível mas sem dispositivos pareados
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
          break;
        }

        // 3️⃣ Bluetooth disponível com dispositivos → mostra BluetoothView
        view = const BluetoothView();
        break;

      default:
        view = const Center(child: Text("Em construção")); // Outras abas ainda não implementadas
    }

    final animatedView = view
        .animate(key: ValueKey(index))
        .slideX(
      begin: direction > 0 ? 1.0 : -1.0,
      end: 0,
      duration: 400.ms,
      curve: Curves.easeOutCubic,
    )
        .fadeIn(duration: 400.ms); // Animação de entrada da view

    return SafeArea(
      child: Column(
        children: [
          RowNetworkTypeWidget(indexSignal: indexSignal), // Seleção de tipo de rede
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
