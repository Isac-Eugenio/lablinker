import 'dart:async';
import 'package:flutter/material.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart' hide signal;

import '../shared/commands/result.dart';
import '../shared/commands/stream_command.dart';

class DebugView extends StatefulWidget {
  const DebugView({super.key});

  @override
  State<DebugView> createState() => _DebugViewState();
}

class _DebugViewState extends State<DebugView> {
  late CommandTeste<String, String> command;

  final Signal<bool> _isRunning = signal(false);

  @override
  void initState() {
    super.initState();
    command = CommandTeste();
    command.executeStream(command.streamTeste());
    command.addListener(() {
      _isRunning.value = command.isRunning;
    });
  }

  @override
  void dispose() {
    command.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    IconData icon = _isRunning.watch(context)
        ? Icons.radio_button_unchecked
        : Icons.play_arrow;

    return Scaffold(
      body: Center(child: body()),
      bottomNavigationBar: FloatingActionButton(
        onPressed: command.cancel,
        child: const Icon(Icons.pause_circle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: command.restart,
        child: Icon(icon),
      ),
    );
  }

  StreamBuilder<Result<String, String>> meuStream() => StreamBuilder(
    stream: command.stream,
    builder: (context, snapshot) {
      final data = snapshot.data;
      if (data == null) {
        return const CircularProgressIndicator();
      }
      return Text(
        data.isRunning
            ? "contador: ${data.value}"
            : data.isSuccess
            ? "Rodou com Sucesso"
            : "Erro",
      );
    },
  );

  Widget body() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      meuStream(),
      const SizedBox(height: 20),
    ],
  );
}

class CommandTeste<TSuccess, TFailure>
    extends StreamCommand<TSuccess, TFailure> {
  Stream<Result<TSuccess, TFailure>> streamTeste() async* {
    int i = 0;
    while (i <= 10) {
      await Future.delayed(const Duration(seconds: 1));
      i++;
      yield Running("$i" as TSuccess);
    }
    yield Success("Pronto o Stream rodou" as TSuccess);
  }

  void restart() => executeStream(streamTeste());
}
