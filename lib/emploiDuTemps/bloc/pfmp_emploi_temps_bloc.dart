import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pfmp_emploi_temps_event.dart';
part 'pfmp_emploi_temps_state.dart';

class PfmpEmploiTempsBloc
    extends Bloc<PfmpEmploiTempsEvent, PfmpEmploiTempsState> {
  PfmpEmploiTempsBloc() : super(const PfmpEmploiTempsInitial()) {
    on<PfmpEmploiTempsGetInfo>(getInfos);
    on<PfmpEmploiTempsSubmit>(submit);
  }

  Pfmp? targetPfmp;

  void getInfos(
    PfmpEmploiTempsGetInfo event,
    Emitter<PfmpEmploiTempsState> emit,
  ) async {
    if (event.pfmpId != null) {
      targetPfmp = await Pfmp.retrieve(event.pfmpId.toString());
    }

    emit(PfmpEmploiTempsInitialized());
  }

  void submit(
    PfmpEmploiTempsSubmit event,
    Emitter<PfmpEmploiTempsState> emit,
  ) async {
    Pfmp newPFMP = new Pfmp(
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
    emit(PfmpEmploiTempsInitial());
  }
}
