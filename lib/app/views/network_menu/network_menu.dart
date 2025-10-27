import 'package:flutter/material.dart';
import 'package:lablinker/app/views/base_view.dart';

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
  @override
  Widget buildBody(BuildContext context){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Menu de Protocolos de Rede",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Aqui você pode gerenciar os protocolos de rede disponíveis no sistema. "
              "Adicione, remova ou configure os protocolos conforme necessário para "
              "atender às suas necessidades de rede.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
