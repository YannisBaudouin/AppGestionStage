part of 'pfmp_insert_bloc.dart';

sealed class PfmpInsertState {
  const PfmpInsertState();
}

final class PfmpInsertInitial extends PfmpInsertState {
  const PfmpInsertInitial();
}

final class PfmpInsertInitialized extends PfmpInsertState {
  const PfmpInsertInitialized();
}