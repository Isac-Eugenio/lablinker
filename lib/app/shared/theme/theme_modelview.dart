import 'package:flutter/material.dart';
import 'package:lablinker/app/shared/theme/theme_repository.dart';

class ThemeModelView extends ValueNotifier<ThemeData> {
  bool isDarkMode;
  final ThemeRepository _repository;

  ThemeModelView({required this.isDarkMode})
      : _repository = ThemeRepository(isDarkMode: isDarkMode),
        super(isDarkMode ? darkTheme : lightTheme);

  /// Alterna entre claro e escuro
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
