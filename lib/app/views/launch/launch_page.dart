import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Material(child: GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      },
      child: Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Launch Page\n\nTap to continue',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ));
  }
}