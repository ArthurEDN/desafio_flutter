import 'dart:async';
import 'package:flutter/foundation.dart';
import 'result.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A argument);

/// Facilita a interação com um ViewModel.
///
/// Encapsula uma ação, expõe seus estados de execução e erro,
/// e garante que não possa ser iniciada novamente até que termine.
///
/// Use [Command0] para ações sem argumentos.
/// Use [Command1] para ações com um argumento.
///
/// As ações devem retornar um.
///
/// Consuma o resultado da ação ouvindo as mudanças,
/// depois chame quando o estado for consumido.
abstract class Command<T> extends ChangeNotifier {
  Command();

  bool _running = false;
  /// Verdadeiro quando a ação está em execução.
  bool get running => _running;

  Result<T>? _result;

  /// Verdadeiro se a ação foi concluída com erro.
  bool get error => _result is Error;

  /// Verdadeiro se a ação foi concluída com sucesso.
  bool get completed => _result is Ok;

  /// Obtém o último resultado da ação.
  Result<T>? get result => _result;

  /// Limpa o último resultado da ação.
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  /// Implementação interna da execução.
  Future<void> _execute(CommandAction0<T> action) async {
    // Garante que a ação não possa ser iniciada várias vezes.
    // Ex: evita múltiplos toques em um botão.
    if (_running) return;

    // Notifica os ouvintes.
    // Ex: botão mostra estado de carregamento.
    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// [Command] sem argumentos.
/// Recebe uma [CommandAction0] como ação.
class Command0<T> extends Command<T> {
  Command0(this._action);

  final CommandAction0<T> _action;

  /// Executa a ação.
  Future<void> execute() async {
    await _execute(_action);
  }
}

/// [Command] com um argumento.
/// Recebe uma [CommandAction1] como ação.
class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  /// Executa a ação com o argumento.
  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}