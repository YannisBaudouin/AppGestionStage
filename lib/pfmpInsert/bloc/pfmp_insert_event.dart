part of 'pfmp_insert_bloc.dart';

sealed class PfmpInsertEvent {
  const PfmpInsertEvent();
}

class PfmpInsert_GetInfos extends PfmpInsertEvent {
  final String? pfmpId;
  const PfmpInsert_GetInfos(this.pfmpId);
}

class PfmpInsert_Submit extends PfmpInsertEvent {
  final String nomSociete;
  final String adresseSoc;
  final String statusJuri;
  final String nomFormate;
  final String contactFor;
  final DateTime dateDeb;
  final DateTime dateFin;
  final BuildContext context;

  const PfmpInsert_Submit(
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

final class PfmpInsertAcceptCharte extends PfmpInsertEvent {
  final bool value;
  const PfmpInsertAcceptCharte({required this.value});
}
