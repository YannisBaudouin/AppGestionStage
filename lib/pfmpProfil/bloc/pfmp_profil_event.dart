part of 'pfmp_profil_bloc.dart';

sealed class PfmpProfilEvent {
  const PfmpProfilEvent();
}

class PfmpProfil_GetInfos extends PfmpProfilEvent {
  final String? pfmpId;
  const PfmpProfil_GetInfos(this.pfmpId);
}

class PfmpProfil_ConvertToPdf extends PfmpProfilEvent {
  final String? pfmpId;
  const PfmpProfil_ConvertToPdf(this.pfmpId);
}
