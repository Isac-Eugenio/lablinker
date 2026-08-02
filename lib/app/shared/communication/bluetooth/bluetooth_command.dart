/*
------------------------------------
Arquivo: bluetooth_command.dart
Descrição: Comando genérico para operações assíncronas de Bluetooth, baseado em AsyncCommand
Autor: Isac Eugenio
------------------------------------
*/

import 'package:lablinker/app/shared/commands/async_command.dart';

// Extende AsyncCommand sem adicionar lógica extra, servindo como comando específico para Bluetooth
class BluetoothCommand<TSuccess extends Object>
    extends AsyncCommand<TSuccess> {}
