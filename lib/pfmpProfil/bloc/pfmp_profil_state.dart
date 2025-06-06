part of 'pfmp_profil_bloc.dart';

sealed class PfmpProfilState {
  const PfmpProfilState();
}

final class PfmpProfilInitial extends PfmpProfilState {
  const PfmpProfilInitial();
}

final class PfmpProfilInitialized extends PfmpProfilState {
  const PfmpProfilInitialized();
}
