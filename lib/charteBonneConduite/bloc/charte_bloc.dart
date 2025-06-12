import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'charte_event.dart';
part 'charte_state.dart';

class CharteBloc extends Bloc<CharteEvent, CharteState> {
  CharteBloc() : super(const CharteInitial()) {
    on<getTextFile>(_getTextFile);
  }

  String mentions = "";

  void _getTextFile(getTextFile event, Emitter<CharteState> emit) async {
    mentions = await rootBundle.loadString(event.path);
    emit(CharteInitialised());
  }
}
