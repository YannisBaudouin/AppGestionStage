part of 'profil_infos_bloc.dart';

sealed class ProfilInfosState {
  const ProfilInfosState();
}

final class ProfilInfosInitial extends ProfilInfosState {
  const ProfilInfosInitial();
}

final class ProfilInfosInitialized extends ProfilInfosState {
  const ProfilInfosInitialized();
}
