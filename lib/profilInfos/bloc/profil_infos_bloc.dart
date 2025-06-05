import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_gestion_stage/class/appUser.dart';

part 'profil_infos_event.dart';
part 'profil_infos_state.dart';

class ProfilInfosBloc extends Bloc<ProfilInfosEvent, ProfilInfosState> {
  ProfilInfosBloc() : super(const ProfilInfosInitial()) {
    on<GetInfos>(getInfos);
  }

  AppUser? user;

  void getInfos(GetInfos event, Emitter<ProfilInfosState> emit) async {
    user = await AppUser.retrieve(
      FirebaseAuth.instance.currentUser!.uid,
    );

    emit(ProfilInfosInitialized());
  }
}
