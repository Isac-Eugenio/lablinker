/*
------------------------------------
Arquivo: theme_modelview.dart
Descrição: Gerencia o tema do app (claro/escuro) usando ValueNotifier e ThemeRepository
Autor: Isac Eugenio
------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/theme/theme_repository.dart';

class ThemeModelView extends ValueNotifier<ThemeData> {
  // Indica se o tema atual é escuro
  bool isDarkMode;

  // Repositório que fornece os temas claro e escuro
  final ThemeRepository _repository;

  // Construtor inicializa o ValueNotifier com o tema correto
  ThemeModelView({required this.isDarkMode})
      : _repository = ThemeRepository(isDarkMode: isDarkMode),
        super(isDarkMode ? darkTheme : lightTheme);

  /// Alterna entre tema claro e escuro
  void toggle() {
    isDarkMode = !isDarkMode;
    value = isDarkMode ? _repository.dark : _repository.light;
    notifyListeners();
  }

  /// Ativa modo escuro
  void dark() {
    if (!isDarkMode) {
      isDarkMode = true;
      value = _repository.dark;
    }
    notifyListeners();
  }

  /// Ativa modo claro
  void light() {
    if (isDarkMode) {
      isDarkMode = false;
      value = _repository.light;
    }
    notifyListeners();
  }
}
