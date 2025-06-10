part of 'log_book_bloc.dart';

sealed class LogBookEvent {
  const LogBookEvent();
}

class InitLogBook extends LogBookEvent {
  final String pfmpId;
  const InitLogBook(this.pfmpId);
}

class LoadLogDay extends LogBookEvent {
  const LoadLogDay();
}

class SaveLogDay extends LogBookEvent {
  final String content;
  final BuildContext context;
  
  SaveLogDay(this.content, this.context);
}

class UpdateSelectedDate extends LogBookEvent {
  final BuildContext context;
  UpdateSelectedDate(this.context);
}