import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pfmp_insert_event.dart';
part 'pfmp_insert_state.dart';

class PfmpInsertBloc extends Bloc<PfmpInsertEvent, PfmpInsertState> {
  PfmpInsertBloc() : super(const PfmpInsertInitial()) {
    on<PfmpInsert_Submit>(_submit);
    on<PfmpInsert_GetInfos>(_getInfos);
    on<PfmpInsertAcceptCharte>(_acceptLegal);
  }

  Pfmp? targetPfmp;
  bool acceptCharte = false;

  void _submit(PfmpInsert_Submit event, Emitter<PfmpInsertState> emit) async {
    if (!(acceptCharte)) {
      return;
    }
    Pfmp newPFMP = Pfmp(
      targetPfmp != null ? targetPfmp!.idPfmp : "",
      event.nomSociete,
      event.adresseSoc,
      event.statusJuri,
      event.nomFormate,
      event.contactFor,
      event.dateDeb,
      event.dateFin,
    );

    if (newPFMP.idPfmp == "") {
      newPFMP.create();
    } else {
      newPFMP.update();
    }

    Navigator.pop(event.context);
    emit(PfmpInsertInitial());
  }

  void _getInfos(
    PfmpInsert_GetInfos event,
    Emitter<PfmpInsertState> emit,
  ) async {
    if (event.pfmpId != null) {
      targetPfmp = await Pfmp.retrieve(event.pfmpId.toString());
    }

    emit(PfmpInsertInitialized());
  }

  void _acceptLegal(
    PfmpInsertAcceptCharte event,
    Emitter<PfmpInsertState> emit,
  ) {
    acceptCharte = event.value;
    emit(PfmpInsertInitial());
  }
}
