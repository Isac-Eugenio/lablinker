import 'package:flutter/material.dart';

class NetworkModel {
  final String name;
  final String address;
  final int? port;
  final String? username;
  final String? password;
  final IconData icon;

  NetworkModel({
    required this.icon,
    required this.name,
    required this.address,
    this.port,
    this.username,
    this.password,
  });
}
