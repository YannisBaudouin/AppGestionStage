part of 'pfmp_profil_bloc.dart';

sealed class PfmpProfilEvent {
  const PfmpProfilEvent();
}

class PfmpProfil_GetInfos extends PfmpProfilEvent {
  final String? pfmpId;
  const PfmpProfil_GetInfos(this.pfmpId);
}

class PfmpProfil_Submit extends PfmpProfilEvent {
  final String nomSociete;
  final String adresseSoc;
  final String statusJuri;
  final String nomFormate;
  final String contactFor;
  final DateTime dateDeb;
  final DateTime dateFin;
  final BuildContext context;

  const PfmpProfil_Submit(
    this.nomSociete,
    this.adresseSoc,
    this.statusJuri,
    this.nomFormate,
    this.contactFor,
    this.dateDeb,
    this.dateFin,
    this.context,
  );
}
