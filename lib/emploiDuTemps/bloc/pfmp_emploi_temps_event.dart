part of 'pfmp_emploi_temps_bloc.dart';

sealed class PfmpEmploiTempsEvent {
  const PfmpEmploiTempsEvent();
}

class PfmpEmploiTempsGetInfo extends PfmpEmploiTempsEvent {
  final String? pfmpId;
  const PfmpEmploiTempsGetInfo(this.pfmpId);
}

class PfmpEmploiTempsSubmit extends PfmpEmploiTempsEvent {
  final String nomSociete;
  final String adresseSoc;
  final String statusJuri;
  final String nomFormate;
  final String contactFor;
  final DateTime dateDeb;
  final DateTime dateFin;
  final BuildContext context;

  const PfmpEmploiTempsSubmit(
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
