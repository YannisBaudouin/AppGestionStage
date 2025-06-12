import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(const AboutInitial()) {
    on<getTextFile>(_getTextFile);
  }

  String mentions = "";

  void _getTextFile(getTextFile event, Emitter<AboutState> emit) async {
    mentions = await rootBundle.loadString(event.path);
    emit(AboutInitialised());
  }
}
