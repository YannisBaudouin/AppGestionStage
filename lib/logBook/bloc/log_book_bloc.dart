import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:app_gestion_stage/customWidget/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_gestion_stage/class/logDay.dart';

part 'log_book_event.dart';
part 'log_book_state.dart';

class LogBookBloc extends Bloc<LogBookEvent, LogBookState> {
  LogBookBloc() : super(const LogBookUnititialized()) {
    on<InitLogBook>(_initLogBook);
    on<LoadLogDay>(_loadLogDay);
    on<SaveLogDay>(_saveLogDay);
    on<UpdateSelectedDate>(_updateSelectedDate);
  }

  LogDay? logDay;
  DateTime? selectedDate;

  Pfmp? pfmp;

  // Initialise le carnet de bord
  void _initLogBook(InitLogBook event, Emitter<LogBookState> emit) async {
    // Initialise l'objet PFMP
    pfmp = await Pfmp.retrieve(event.pfmpId);

    // Choisis une date par défaut, qui est soit le premier jour du stage, soit la date d'aujourd'hui si elle fait partie du stage
    selectedDate =
        DateTime.now().isBefore(pfmp!.endDate) &
            DateTime.now().isAfter(pfmp!.startDate)
        ? DateTime.now()
        : pfmp!.startDate;

    emit(LogBookInitialized());
  }

  // Charge le jour actuelle du carnet de bord
  void _loadLogDay(LoadLogDay event, Emitter<LogBookState> emit) async {
    logDay = await LogDay.retrieveFromDate(
      selectedDate as DateTime,
      pfmp!.idPfmp,
    );

    // Créer le LogDay dans la base de donnée s'il n'existe pas
    if (logDay == null) {
      logDay = LogDay("", pfmp!.idPfmp, selectedDate as DateTime, "");
      logDay!.create();
    }

    emit(LogDayInitialized());
  }

  // Sauvegarde le LogDay (duh)
  void _saveLogDay(SaveLogDay event, Emitter<LogBookState> emit) {
    logDay?.content = event.content;

    logDay!.update();

    customShowDialog(
      event.context,
      "Jour sauvegardé !",
      "Jour sauvegardé avec succès",
      <Widget>[CustomREB(context: event.context, text: "OK")],
    );

    emit(LogDayInitialized());
  }

  // Affiche un DatePicker et met à jour la date sélectionner
  void _updateSelectedDate(
    UpdateSelectedDate event,
    Emitter<LogBookState> emit,
  ) async {
    selectedDate = await showDatePicker(
      context: event.context,
      initialDate: selectedDate,
      firstDate: pfmp!.startDate,
      lastDate: pfmp!.endDate,
    );

    emit(LogBookInitialized());
  }
}
