part of 'profil_edit_bloc.dart';

sealed class ProfilEditEvent {
  const ProfilEditEvent();
}

final class ProfilEdit_GetInfos extends ProfilEditEvent {
  const ProfilEdit_GetInfos();
}

final class SubmitEdits extends ProfilEditEvent {
  final String fName;
  final String lName;
  final DateTime birthDate;
  final BuildContext context;

  const SubmitEdits(this.fName, this.lName, this.birthDate, this.context);
}

final class ProfilEditInputsChanged extends ProfilEditEvent {
  final String prenom;
  final String nom;
  const ProfilEditInputsChanged({required this.prenom, required this.nom});
}
