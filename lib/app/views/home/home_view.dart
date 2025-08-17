import 'package:flutter/material.dart';
import 'package:lablinker/app/views/home/widgets/app_bar_home_widget.dart';
import 'package:lablinker/app/views/home/widgets/list_home_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ListHomeWidget listWidget = ListHomeWidget(context);
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade400,
      appBar: AppBarHomeWidget(),
      body: SingleChildScrollView(
        child: Center(
          heightFactor: 1.1,
          widthFactor: 2,
          child: listWidget.wrapMenu,
        ),
      ),
    );
  }
}
