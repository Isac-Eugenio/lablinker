import 'package:flutter/material.dart';
import 'package:lablinker/app/models/add_view_form_model.dart';
import 'package:lablinker/app/models/network_model.dart';
import 'package:lablinker/app/shared/modelviews/bluetooth_modelview.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/shared/widgets/custom_app_bar_widget.dart';
import 'package:lablinker/app/views/form_new_scene/widgets/add_network_button_widget.dart';
import 'package:lablinker/app/views/form_new_scene/widgets/dropdown_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

import '../../models/default_network_model.dart';
import '../../models/protocol_model.dart';
import '../../shared/modelviews/http_modelview.dart';
import '../../shared/theme/theme_widgets.dart';
import '../../shared/widgets/custom_textfield_form_widget.dart';

abstract class FormNewSceneView extends StatelessWidget {
  final void Function()? onPressedSaveButton;
  final RoutesName rollbackRoute;
  final String titleView;

  FormNewSceneView({
    super.key,
    this.onPressedSaveButton,
    required this.rollbackRoute,
    required this.titleView,
  });

  // Sinais para campos de texto
  final Signal<String?> titleSignal = Signal(null);
  final Signal<String?> descriptionSignal = Signal(null);

  // Sinais para protocolo
  final Signal<ProtocolsEnum?> protocols = Signal(null);
  final Signal<String?> textDropdownProtocols = Signal(null);
  final Signal<IconData?> iconDropdownProtocols = Signal(null);

  // Sinais para rede
  final Signal<NetworkModel?> selectedNetwork = Signal(null);
  final Signal<String?> textDropdownNetworks = Signal(null);
  final Signal<IconData?> iconDropdownNetworks = Signal(null);

  late final ValueNotifier<AddViewFormModel>? selectedFormModel = null;

  BluetoothModelView bluetoothModelView(BuildContext context) =>
      context.watch<BluetoothModelView>();

  HttpModelView httpModelView(BuildContext context) =>
      context.watch<HttpModelView>();

  List<DropdownMenuItem<ProtocolsEnum>> protocolItems(BuildContext context) =>
      List.generate(
        ProtocolsEnum.values.length,
        (index) => DropdownMenuItem(
          value: ProtocolsEnum.values[index],
          child: Row(
            children: [
              Icon(ProtocolsEnum.icons[index]),
              const SizedBox(width: 8),
              Text(
                ProtocolsEnum.labels[index],
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      );

  List<DropdownMenuItem<NetworkModel>>? networkItems(BuildContext context) {
    ProtocolsEnum? protocol = protocols.watch(context);

    if (protocol != null) {
      if (protocol == ProtocolsEnum.bluetooth) {
        var bluetooth = bluetoothModelView(context);
        final networks = bluetooth.value.networks;

        if (networks != null && networks.isNotEmpty) {
          return List.generate(networks.length, (index) {
            return DropdownMenuItem(
              value: networks[index],
              child: Row(
                children: [
                  Icon(networks[index].icon),
                  const SizedBox(width: 8),
                  Text(
                    networks[index].name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            );
          });
        }
      } else if (protocol == ProtocolsEnum.http) {
        var http = httpModelView(context);
        final networks = http.value.networks;

        if (networks != null && networks.isNotEmpty) {
          return List.generate(networks.length, (index) {
            return DropdownMenuItem(
              value: networks[index],
              child: Row(
                children: [
                  Icon(networks[index].icon),
                  const SizedBox(width: 8),
                  Text(
                    networks[index].name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            );
          });
        }
      }
    }
    return null; // sem redes → não renderiza dropdown
  }

  void setProtocols(ProtocolsEnum? protocol) {
    protocols.value = protocol;
    textDropdownProtocols.value = protocol?.label;
    iconDropdownProtocols.value = protocol?.icon;

    // reset de redes ao trocar protocolo
    selectedNetwork.value = null;
    textDropdownNetworks.value = null;
    iconDropdownNetworks.value = null;
  }

  void setNetwork(NetworkModel? network) {
    final chosen = network ?? DefaultNetworkModel();
    selectedNetwork.value = chosen;
    textDropdownNetworks.value = chosen.name;
    iconDropdownNetworks.value = chosen.icon;
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = ColorsPrimarySystem.backgroundPrimaryColor.color;
    TextTheme fonts = TextTheme.of(context);

    final items = networkItems(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBarWidget(title: titleView, route: rollbackRoute),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorsPrimarySystem.primaryColor.color,
        onPressed: onPressedSaveButton,
        icon: const Icon(Icons.save, color: Colors.white),
        label: Text("Salvar", style: fonts.titleSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            child: Column(
              children: [
                CustomTextFieldFormWidget(
                  label: "Título",
                  maxLength: 20,
                  onChanged: (value) => titleSignal.value = value,
                ),
                const SizedBox(height: 16),

                CustomTextFieldFormWidget(
                  label: "Descrição",
                  maxLength: 100,
                  onChanged: (value) => descriptionSignal.value = value,
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 48,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownFormWidget<ProtocolsEnum>(
                      title: "Selecione um protocolo",
                      onChanged: setProtocols,
                      items: protocolItems(context),
                      textDropdown: textDropdownProtocols,
                      iconDropdown: iconDropdownProtocols,
                      selectedValue: protocols,
                    ),
                  ),
                ),

                if (protocols.watch(context) != null && items != null) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownFormWidget<NetworkModel>(
                              title: "Selecione uma conexão",
                              onChanged: setNetwork,
                              items: items,
                              textDropdown: textDropdownNetworks,
                              iconDropdown: iconDropdownNetworks,
                              selectedValue: null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (protocols.watch(context) == ProtocolsEnum.bluetooth)
                        AddNetworkButtonWidget(
                          formModelNotifier: bluetoothModelView(context),
                        )
                      else if (protocols.watch(context) == ProtocolsEnum.http)
                        AddNetworkButtonWidget(
                          formModelNotifier: httpModelView(context),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
