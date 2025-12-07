import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/bluetooth_service.dart';
import 'package:lablinker/app/views/bluetooth/bluetooth_state.dart';
import '../../models/message_model.dart';
import '../../shared/commands/result.dart';
import '../bluetooth/bluetooth_model_view.dart';

class ConsoleModelview extends ChangeNotifier {
  final BuildContext context;
  final BluetoothModelView bluetooth;

  final TextEditingController commandController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<MessageModel> messages = [];

  BluetoothState get bluetoothState => bluetooth.state;

  // Variável para armazenar o buffer parcial (resto de uma mensagem incompleta)
  String _inputBuffer = '';

  // Delimitador que seu microcontrolador usa (ex: '\n' para nova linha)
  static const String _delimiter = '\n';

  // Variável para armazenar o último dado TOTAL recebido para rastrear o que é NOVO (Buffer de Estado)
  String _lastReceivedData = '';

  String? _lastValidReceivedMessage;

  ConsoleModelview(this.bluetooth, this.context) {
    bluetooth.addListener(_handleReceivedData);
  }

  // LÓGICA DE PARSING DE DADOS RECEBIDOS
  void _handleReceivedData() {
    // Acessa o novo dado recebido do Bluetooth.
    final currentReceivedData = bluetooth.receivedData;
    final currentLength = currentReceivedData.length;

    if (currentLength < _lastReceivedData.length) {
      // Isso significa que o buffer do Bluetooth foi resetado/truncado (ex: desconexão).
      // Resetamos o buffer de estado para 0 para evitar RangeError.
      _lastReceivedData = '';
      _inputBuffer = ''; // Também limpa o buffer parcial
    }

    // 2. CORREÇÃO CRÍTICA: Verifica se o dado mudou. Se não mudou, retorna para evitar processamento.
    if (currentReceivedData == _lastReceivedData) {
      return;
    }

    // --- LÓGICA PARA EXTRAIR O CHUNK NOVO ---

    // Calcula o novo pedaço de dados. Se o 'currentReceivedData' for o buffer acumulado,
    // o novo chunk é o substring que começa no final do último buffer processado.
    final int oldLength = _lastReceivedData.length;
    final String newDataChunk = currentReceivedData.substring(oldLength);

    // Se o chunk for vazio (o que não deve acontecer devido à verificação acima, mas como segurança)
    if (newDataChunk.isEmpty) {
      return;
    }

    // Atualiza o buffer de estado com o novo TOTAL para o próximo ciclo.
    _lastReceivedData = currentReceivedData;

    // 3. LÓGICA DE PARSING COM DELIMITADOR
    // Concatena o buffer parcial (resto de um ciclo anterior) APENAS com o NOVO chunk de dados.
    _inputBuffer += newDataChunk;

    // Divide o buffer pelos delimitadores.
    final parts = _inputBuffer.split(_delimiter);

    // O último elemento será o novo buffer parcial, pois ele pode estar incompleto.
    _inputBuffer = parts.last;

    // Processa todos os pedaços COMPLETOs (exceto o último)
    final completeMessages = parts.sublist(0, parts.length - 1);

    // Variável para armazenar as novas mensagens filtradas.
    final List<MessageModel> newFilteredMessages = [];

    // Variável de controle LOCAL removida; usamos _lastValidReceivedMessage

    for (var msgText in completeMessages) {
      // 4. VERIFICAÇÃO DE DEDUPLICAÇÃO
      if (msgText.isNotEmpty) {
        // Remove espaços em branco antes e depois para garantir a comparação
        final trimmedText = msgText.trim();

        // 4A. Verifica repetição: Compara com a última mensagem VÁLIDA registrada no estado da classe.
        // Isso impede repetições entre diferentes chamadas (e dentro do mesmo chunk).
        if (trimmedText == _lastValidReceivedMessage) {
          continue; // Ignora esta repetição e continua para a próxima
        }

        // 4B. Adiciona a mensagem filtrada e ATUALIZA O RASTREADOR DE ESTADO GLOBAL
        newFilteredMessages.add(MessageModel(trimmedText, false));
        _lastValidReceivedMessage = trimmedText; // <-- CHAVE DA CORREÇÃO
      }
    }

    // 5. ADICIONA AS MENSAGENS FILTRADAS À LISTA PRINCIPAL
    if (newFilteredMessages.isNotEmpty) {
      messages.addAll(newFilteredMessages);
      notifyListeners();
      _scrollToBottom();
    }
  }

  // Método auxiliar para rolar para o final da lista (usado em sendCommand e _handleReceivedData)
  void _scrollToBottom() {
    // Agenda a rolagem para o final após o frame ser desenhado.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendCommand(String command) async {
    if (command.isEmpty || bluetooth.connectedDevice == null) return;

    // NOTA: Adicionei o delimitador ao comando enviado para que o microcontrolador possa parsear.
    String commandWithDelimiter = '$command$_delimiter';

    Result<void, String> result = await bluetooth.sendMessage(
      commandWithDelimiter,
    );

    if (result.isFailure) {
      // AVISO: Mantenha a interface de usuário (UI) limpa. Use SnackBar APENAS para erros.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao Enviar a mensagem !"),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Adiciona a mensagem do usuário (sem o delimitador) à lista.
    messages.add(MessageModel(command, true));

    commandController.clear();
    notifyListeners();

    _scrollToBottom(); // Reutiliza a função de rolagem
  }
  void clearMessages() {
    messages.clear();
    commandController.clear();

    // Resetar buffers locais do parser
    _inputBuffer = '';
    _lastReceivedData = '';
    _lastValidReceivedMessage = null;

    // Resetar buffer real de dados vindos do bluetooth
    bluetooth.clearBuffer();

    notifyListeners();
  }



  @override
  void dispose() {
    // 5. LIMPEZA: OBRIGATÓRIO: Remover o listener do BluetoothModelView
    bluetooth.removeListener(_handleReceivedData);
    commandController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
