import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_gestion_stage/class/appUser.dart';
import 'package:app_gestion_stage/customWidget/custom_widget.dart';

part 'profil_edit_event.dart';
part 'profil_edit_state.dart';

class ProfilEditBloc extends Bloc<ProfilEditEvent, ProfilEditState> {
  ProfilEditBloc() : super(const ProfilEditInitial()) {
    on<ProfilEdit_GetInfos>(getInfos);
    on<SubmitEdits>(submitEdits);
  }

  AppUser? user;

  void getInfos(
    ProfilEdit_GetInfos event,
    Emitter<ProfilEditState> emit,
  ) async {
    user = await AppUser.retrieve(FirebaseAuth.instance.currentUser!.uid);
    emit(ProfilEditInitialized());
  }

  void submitEdits(SubmitEdits event, Emitter<ProfilEditState> emit) {
    user!.firstName = event.fName;
    user!.lastName = event.lName;
    user!.birthDate = event.birthDate;

    user!.update();

    List<Widget> popupOption = [
      CustomRTB(text: "OK"),
    ];
    customShowDialog(event.context, "Modifications", "Votre profil a été édité avec succès", popupOption);

    Navigator.pop(event.context);
    emit(ProfilEditSucceeded());
  }
}
