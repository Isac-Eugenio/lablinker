import 'package:flutter/material.dart';

/// Classe base abstrata para views
abstract class BaseView extends StatefulWidget {
  final String title;
  final bool rollback;
  final String? route;

  final IconData? floatingActionButtonIcon;
  final VoidCallback? floatingActionButtonOnPressed;
  final bool floatingActionButtonVisible;

  final List<Widget>? actionsAppBar;

  final Function()? functionInitState;
  final Function()? functionDispose;
  final Function()? functionDidChangeDependencies;

  const BaseView({
    super.key,
    required this.title,
    this.rollback = false,
    this.route,
    this.floatingActionButtonIcon,
    this.floatingActionButtonOnPressed,
    this.floatingActionButtonVisible = false,
    this.actionsAppBar,
    this.functionInitState,
    this.functionDispose,
    this.functionDidChangeDependencies,
  });

  /// As subclasses devem retornar seu próprio State
  @override
  BaseViewState createState();
}

/// Classe base do State com método abstrato buildBody()
abstract class BaseViewState<T extends BaseView> extends State<T>{
  @override
  void initState() {
    super.initState();
    widget.functionInitState?.call();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.functionDidChangeDependencies?.call();
  }

  @override
  void dispose() {
    widget.functionDispose?.call();
    super.dispose();
  }

  /// Método abstrato que subclasses DEVEM implementar
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: widget.rollback
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (widget.route != null) {
                    Navigator.of(context).pushReplacementNamed(widget.route!);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              )
            : null,
        actions: widget.actionsAppBar,
      ),
      body: buildBody(context),
      floatingActionButton: widget.floatingActionButtonVisible
          ? FloatingActionButton(
              onPressed: widget.floatingActionButtonOnPressed,
              child: Icon(widget.floatingActionButtonIcon),
            )
          : null,
    );
  }
}
