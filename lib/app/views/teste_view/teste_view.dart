/*
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import 'package:lablinker/app/views/base_view.dart';
import 'package:lablinker/app/views/teste_view/teste_modelview.dart';
import 'package:provider/provider.dart';

class TesteView extends BaseView {
  TesteView({super.key})
    : super(

        title: 'Testando Bluetooth',
        rollback: false,
        floatingActionButtonVisible: false,
        actionsAppBar: [],
      );

  @override
  BaseViewState<BaseView> createState() => _TesteViewState();
}

class _TesteViewState extends BaseViewState<TesteView> {
  final TextEditingController _controller = TextEditingController();

  late TesteModelview model;

  late String msg;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pega o model do Provider
    model = Provider.of<TesteModelview>(context);

    // Adiciona listener apenas uma vez
    model.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    model.disconnectDevice();
    model.dispose();
    super.dispose();
  }

  void showMessage(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget buildBody(BuildContext context) => SingleChildScrollView(
    child: Center(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                model.initializeBluetooth().then((result) {
                  if (result.isSuccess) {
                    showMessage('Bluetooth inicializado com sucesso');
                  } else if (result.isFailure) {
                    showMessage(
                      'Erro ao inicializar Bluetooth: ${result.failureOrNull}',
                    );
                  }
                });
              },
              icon: Icon(
                Icons.bluetooth,
                color: model.isBluetoothAvailable ? Colors.blue : Colors.grey,
              ),
            ),
          ),

          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Dispositivos pareados:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.getPairedDevices.length,
                    itemBuilder: (context, index) {
                      BluetoothDevice device =
                          model.getConnectedDevice ??
                          model.getPairedDevices[index];

                      return ListTile(
                        title: Text(device.name),
                        subtitle: Text(device.address),
                        trailing: ElevatedButton(
                          onPressed: () {
                            model.connectToDevice(device).then((result) {
                              if (result.isSuccess) {
                                showMessage('Conectado a ${device.name}');
                              } else if (result.isFailure) {
                                showMessage(
                                  'Erro ao conectar a ${device.name}: ${result.failureOrNull}',
                                );
                              }
                            });
                          },
                          child: const Text('Conectar'),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      model.updateListDevice(); // seu botão de update
                    },
                    child: const Text('Atualizar Dispositivos'),
                  ),

                  SizedBox(height: 16),

                  TextField(
                    controller: _controller, // <--- Controller mantém o texto
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(
                      labelText: 'Mensagem',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      msg =
                          value; // opcional, caso precise guardar separadamente
                    },
                  ),

                  SizedBox(height: 4),

                  ElevatedButton(
                    onPressed: () {
                      model.sendMessage(msg).then((result) {
                        if (result.isSuccess) {
                          msg = "";
                          showMessage('Mensagem enviada com sucesso');
                        } else if (result.isFailure) {
                          showMessage(
                            'Erro ao enviar mensagem: ${result.failureOrNull}',
                          );
                        }
                      });
                    },
                    child: const Text('Enviar Mensagem'),
                  ),

                  SizedBox(height: 16),

                  
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
*/
