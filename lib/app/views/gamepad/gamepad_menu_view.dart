import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/routes/routes.dart';
import 'package:lablinker/app/views/base_view.dart';

class GamepadMenuView extends BaseView {
  GamepadMenuView({super.key})
    : super(
        title: 'Gamepad Menu',
        rollback: true,
        route: Routes.home,
        floatingActionButtonIcon: Icons.add,
        floatingActionButtonVisible: true,
        floatingActionButtonOnPressed: null,
      );

  @override
  BaseViewState<BaseView> createState() => GamepadMenuViewState();
}

class GamepadMenuViewState extends BaseViewState<GamepadMenuView> {
  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: Center(
            child: Text('Gamepad Menu Content Here'),
          ),
        ),
      ],
    );
  }
}
