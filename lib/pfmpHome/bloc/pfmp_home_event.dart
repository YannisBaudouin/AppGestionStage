part of 'pfmp_home_bloc.dart';

sealed class PfmpHomeEvent {
  const PfmpHomeEvent();
}

class PfmpHome_GetListWidgets extends PfmpHomeEvent {
  final BuildContext context;
  const PfmpHome_GetListWidgets({required this.context});
}

class PfmpHome_AddWidget extends PfmpHomeEvent {
  const PfmpHome_AddWidget();
}

class PfmpHome_EditWidget extends PfmpHomeEvent {
  const PfmpHome_EditWidget();
}