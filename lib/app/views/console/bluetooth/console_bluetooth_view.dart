import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/views/base_view.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_case.dart';
import 'package:lablinker/app/views/console/bluetooth/console_bluetooth_model_view.dart';
import 'package:provider/provider.dart';

class ConsoleBluetoothView extends BaseView {
  final String titleView;
  ConsoleBluetoothView({super.key, required this.titleView})
    : super(
        title: titleView,
        rollback: true,
        route: Routes.protocolsRoute.path,
      );

  @override
  BaseViewState createState() => ConsoleBluetoothViewState();
}

class ConsoleBluetoothViewState extends BaseViewState {
  late final ConsoleBluetoothModelView model;

  @override
  void initState() {
    super.initState();

    model = ConsoleBluetoothModelView(context.read<BluetoothCase>());

    model.addListener(_onModelChanged);

    Future.microtask(() => model.init());
  }

  void _onModelChanged() {
    if (mounted) {
      setState(() {});
    }
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

    return Center(
      child: ElevatedButton(
        onPressed: () {
          model
              .update()
              .then((v) {
                debugPrint("Carregando");
              })
              .whenComplete(() {
                debugPrint("${model.devicePaired}");
              });
        },
        child: Text("teste"),
      ),
    );
  }
}
