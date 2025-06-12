import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mention_legal_event.dart';
part 'mention_legale_state.dart';

class MentionLegaleBloc extends Bloc<MentionLegaleEvent, MentionLegaleState> {
  MentionLegaleBloc() : super(const MentionLegaleInitial()) {
    on<getTextFile>(_getTextFile);
  }

  String mentions = "";

  void _getTextFile(getTextFile event, Emitter<MentionLegaleState> emit) async {
    mentions = await rootBundle.loadString(event.path);
    emit(MentionLegaleInitialised());
  }
}
