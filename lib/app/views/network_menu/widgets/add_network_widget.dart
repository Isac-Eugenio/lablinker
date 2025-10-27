import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';

class AddNetworkWidget extends StatelessWidget {

  final String routeRollback;

  const AddNetworkWidget({super.key, required this.routeRollback});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, Routes.addNetwork),
    );
  }
}