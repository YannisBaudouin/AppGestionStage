part of 'log_book_bloc.dart';

sealed class LogBookState {
  const LogBookState();
}

class LogBookUnititialized extends LogBookState {
  const LogBookUnititialized();
}

// Si le LogBook est initialisé, mais que le LogDay non
class LogBookInitialized extends LogBookState {
  const LogBookInitialized();
}

// Si le LogBook et le LogDay sont initialisées (le LogDay ne peut théoriquement pas être initialisé sans le LogBook)
class LogDayInitialized extends LogBookState {
  const LogDayInitialized();
}