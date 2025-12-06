import 'dart:async';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import '../../shared/commands/result.dart';
import 'bluetooth_listeners.dart';

class BluetoothRepository implements BluetoothCallbacks {
  final FlutterBluetoothClassic _bluetooth = FlutterBluetoothClassic();
  late final BluetoothListeners _listeners;

  final _connectionController =
      StreamController<BluetoothConnectionState>.broadcast();
  final _dataController = StreamController<String>.broadcast();

  Stream<BluetoothConnectionState> get connectionStream =>
      _connectionController.stream;

  Stream<String> get dataStream => _dataController.stream;

  FlutterBluetoothClassic get bluetoothClassic => _bluetooth;

  BluetoothRepository() {
    _listeners = BluetoothListeners(bluetooth: _bluetooth, callbacks: this);
  }

  // Inicialização
  Future<bool> init() async {
    try {
      final supported = await _bluetooth.isBluetoothSupported();
      final enabled = await _bluetooth.isBluetoothEnabled();
      final available = supported && enabled;

      if (!available) return false;

      _listeners.start();
      return true;
    } catch (e) {
      throw 'Erro ao inicializar Bluetooth: $e';
    }
  }

  // Obter dispositivos pareados
  Future<List<BluetoothDevice>> getPairedDevices() async {
    try {
      return await _bluetooth.getPairedDevices();
    } catch (e) {
      throw 'Erro ao obter dispositivos pareados: $e';
    }
  }

  // Substitua o seu método connect() por este:
  Future<Result<bool, String>> connect(String address) async {
    try {
      // 1. Inicia o processo de conexão (pode retornar True imediatamente).
      await _bluetooth.connect(address);

      // 2. Espera pelo PRIMEIRO evento de mudança de estado do dispositivo em 'address'.
      // O where() filtra para garantir que estamos olhando para o dispositivo correto.
      final state = await _bluetooth.onConnectionChanged
          .firstWhere((s) => s.deviceAddress == address)
          // Adicionamos um timeout, pois a conexão Bluetooth pode falhar por inatividade.
          .timeout(const Duration(seconds: 5));

      // 3. Verifica o estado. Se chegou até aqui, o processo assíncrono finalizou.
      if (state.isConnected) {
        // Retorna sucesso se o estado final é conectado.
        return Success(true);
      } else {
        // Se não estiver conectado (ex: o estado final foi 'disconnected' após a tentativa).
        return Failure(
          'Falha ao conectar ao dispositivo $address. Estado final: ${state.isConnected}',
        );
      }
    } on TimeoutException {
      // Captura o erro se o Future não resolver no tempo limite.
      return Failure('Erro de Timeout ao conectar ao dispositivo $address.');
    } catch (e) {
      // Captura erros síncronos (ex: permissões) ou outros erros assíncronos não tratados pelo Stream.
      return Failure('Erro ao conectar ao dispositivo $address: $e');
    }
  }

  // Desconectar
  Future<Result<void, String>> disconnect() async {
    try {
     var r =  await _bluetooth.disconnect();
      if(!r){
        throw Exception("Desconexão mal-sucedida");
      }

      return Success(null);

    } catch (e) {
      return Failure('Erro ao desconectar: $e');
    }
  }

  Future<Result<void, String>> sendMessage(String msg) async {
    try {
      await _bluetooth.sendString(msg);
      return Success(null);
    } catch (e) {
      return Failure('Erro ao enviar mensagem: $e');
    }
  }

  // LISTENER CALLBACKS
  @override
  void onConnectionChanged(BluetoothConnectionState state) {
    _connectionController.add(state);
  }

  @override
  void onDataReceived(BluetoothData data) {
    _dataController.add(data.asString());
  }

  void dispose() {
    _listeners.dispose();
    _connectionController.close();
    _dataController.close();
  }
}
