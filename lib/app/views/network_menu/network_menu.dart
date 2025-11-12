import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lablinker/app/shared/cases/bluetooth_case.dart';
import 'package:lablinker/app/shared/commands/result.dart';
import 'package:lablinker/app/shared/widgets/notification_widget.dart';
import 'package:lablinker/app/views/base_view.dart';
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
  late BluetoothCase bluetooth;

  final indexSignal = signal(0);
  int previousIndex = 0;

  Future<Result>? _initBluetoothFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bluetooth = Provider.of<BluetoothCase>(context, listen: false);
  }

  Future<Result> _initializeBluetoothOnce() {
    // Se já inicializou antes, atualiza a lista.
    if (_initBluetoothFuture != null) {
      return bluetooth.updateListDevice();
    }

    // Caso contrário, inicializa o Bluetooth e guarda o Future.
    _initBluetoothFuture = bluetooth.initializeBluetooth();
    return _initBluetoothFuture!;
  }

  @override
  Widget buildBody(BuildContext context) {
    final index = indexSignal.watch(context);
    final direction = (index - previousIndex).sign;
    previousIndex = index;

    Widget view;

    switch (index) {
      case 0:
        view = FutureBuilder<Result>(
          future: _initializeBluetoothOnce(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro inesperado: ${snapshot.error}'));
            }

            if (snapshot.hasData && snapshot.data!.isFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                NotificationWidget(
                  context: context,
                  message:
                      'Erro ao inicializar Bluetooth: ${snapshot.data!.failureOrNull}',
                  durationSeconds: 3,
                );
              });
            }

            return const BluetoothView();
          },
        );
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
