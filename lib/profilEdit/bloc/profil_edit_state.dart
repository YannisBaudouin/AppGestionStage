part of 'profil_edit_bloc.dart';

sealed class ProfilEditState {
  const ProfilEditState();
}

final class ProfilEditInitial extends ProfilEditState {
  const ProfilEditInitial();
}

final class ProfilEditInitialized extends ProfilEditState {
  const ProfilEditInitialized();
}

final class ProfilEditSucceeded extends ProfilEditState {
  const ProfilEditSucceeded();
}

final class ProfilEditChanged extends ProfilEditState {
  const ProfilEditChanged();
}
