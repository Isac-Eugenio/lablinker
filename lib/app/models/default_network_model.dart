import 'package:flutter/material.dart';
import 'package:lablinker/app/models/network_model.dart';

class DefaultNetworkModel extends NetworkModel {
  DefaultNetworkModel()
    : super(name: "Sem Conexões", icon: Icons.settings, address: '0:0:0:0');
}
