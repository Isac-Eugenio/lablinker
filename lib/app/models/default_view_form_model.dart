import 'package:lablinker/app/models/add_view_form_model.dart';
import 'package:lablinker/app/models/default_network_model.dart';
import 'package:lablinker/app/models/protocol_model.dart';

class DefaultViewFormModel extends AddViewFormModel {
  DefaultViewFormModel()
    : super(
        ViewsEnum.gamepad,
        description: "Configuração padrão",
        protocol: ProtocolsEnum.protocolDefault,
        networks: [DefaultNetworkModel()],
      );
}
