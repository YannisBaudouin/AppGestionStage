import 'package:app_gestion_stage/class/pfmp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pfmp_profil_event.dart';
part 'pfmp_profil_state.dart';

class PfmpProfilBloc extends Bloc<PfmpProfilEvent, PfmpProfilState> {
  PfmpProfilBloc() : super(const PfmpProfilInitial()) {
    on<PfmpProfil_GetInfos>(_getInfo);
  }

  Pfmp? targetPfmp;

  void _getInfo(
    PfmpProfil_GetInfos event,
    Emitter<PfmpProfilState> emit,
  ) async {
    if (event.pfmpId != null) {
      targetPfmp = await Pfmp.retrieve(event.pfmpId.toString());
    }

    emit(PfmpProfilInitialized());
  }
}
