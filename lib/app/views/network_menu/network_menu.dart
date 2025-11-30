import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  bool _bluetoothInitialized = false;
  int previousIndex = 0;

  final views = [
    // BluetoothView será carregada via FutureBuilder
    null,
    const Center(child: Text("Rede Wi-Fi")),
    const Center(child: Text("Configurações")),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bluetoothModel = Provider.of<BluetoothModelView>(context, listen: false);

    // Atualiza a UI sempre que o estado mudar
    bluetoothModel.addListener(() {
      if (mounted) setState(() {});
    });

    // Inicializa o Bluetooth **uma única vez**
    if (!_bluetoothInitialized) {
      _bluetoothInitialized = true;
      bluetoothModel.initializeBluetooth();
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    bluetoothModel = Provider.of<BluetoothModelView>(
      context,
    ); // listen: true por padrão
    final index = indexSignal.watch(context);
    final direction = (index - previousIndex).sign;
    previousIndex = index;

    Widget content;
    if (indexSignal.value == 0) {
      final state = bluetoothModel.state;
      debugPrint("${state.isAvailable}, ${state.pairedDevices}");

      if (!state.isAvailable) {
        content = const Center(child: CircularProgressIndicator());
      } else if (state.connectionState?.isConnected ?? false) {
        content = const BluetoothView();
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          NotificationWidget(
            context: context,
            message: "Erro ao conectar ao dispositivo",
            durationSeconds: 2,
          );
        });
        content = const Center(child: Text("Erro ao conectar"));
      }
    } else {
      content = views[indexSignal.value]!;
    }

    final animatedView = content
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
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity != null) {
                  if (details.primaryVelocity! < -300 &&
                      indexSignal.value < views.length - 1) {
                    indexSignal.value += 1;
                  } else if (details.primaryVelocity! > 300 &&
                      indexSignal.value > 0) {
                    indexSignal.value -= 1;
                  }
                }
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: animatedView,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
