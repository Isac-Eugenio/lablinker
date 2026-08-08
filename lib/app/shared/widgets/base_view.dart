/*
-----------------------------------------------------------
Arquivo: base_view.dart
Descrição: Classes base para Views no app.
           BaseView é o StatefulWidget abstrato com parâmetros
           comuns (título, rollback, FAB, ações do AppBar).
           BaseViewState define o ciclo de vida e exige implementação
           de buildBody() pelas subclasses.
Autor: Isac Eugenio
-----------------------------------------------------------
*/

import 'package:flutter/material.dart';

/// Classe base abstrata para views
abstract class BaseView extends StatefulWidget {
  final String title; // Título da AppBar
  final bool rollback; // Indica se tem botão de voltar
  final String? route; // Rota de retorno ao clicar no botão de voltar

  final IconData? floatingActionButtonIcon; // Ícone do FAB
  final VoidCallback? floatingActionButtonOnPressed; // Ação do FAB
  final bool floatingActionButtonVisible; // Visibilidade do FAB

  final List<Widget>? actionsAppBar; // Ações extras da AppBar

  final Function()? functionInitState; // Função opcional no initState
  final Function()? functionDispose; // Função opcional no dispose
  final Function()? functionDidChangeDependencies; // Função opcional no didChangeDependencies

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

  /// Subclasses devem retornar seu próprio State
  @override
  BaseViewState createState();
}

/// Classe base do State com método abstrato buildBody()
abstract class BaseViewState<T extends BaseView> extends State<T> {
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
