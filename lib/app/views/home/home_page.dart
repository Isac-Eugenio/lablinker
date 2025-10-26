import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/widgets/app_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Home', rollback: false),

      body: Expanded(child: Center(child: Text('Welcome to the Home Page!'))),
    );
  }
}
