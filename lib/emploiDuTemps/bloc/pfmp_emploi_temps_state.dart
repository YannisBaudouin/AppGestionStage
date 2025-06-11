part of 'pfmp_emploi_temps_bloc.dart';

sealed class PfmpEmploiTempsState {
  const PfmpEmploiTempsState();
}

final class PfmpEmploiTempsInitial extends PfmpEmploiTempsState {
  const PfmpEmploiTempsInitial();
}

final class PfmpEmploiTempsInitialized extends PfmpEmploiTempsState {
  const PfmpEmploiTempsInitialized();
}
