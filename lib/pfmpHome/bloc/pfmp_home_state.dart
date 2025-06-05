part of 'pfmp_home_bloc.dart';

sealed class PfmpHomeState {
  const PfmpHomeState();
}

final class PfmpHomeInitial extends PfmpHomeState {
  const PfmpHomeInitial();
}

final class PfmpHomeInitialized extends PfmpHomeState {
  const PfmpHomeInitialized();
}