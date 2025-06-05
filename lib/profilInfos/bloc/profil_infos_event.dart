part of 'profil_infos_bloc.dart';

sealed class ProfilInfosEvent {
  const ProfilInfosEvent();
}

final class GetInfos extends ProfilInfosEvent {
  const GetInfos();
}