part of 'mail_con_bloc.dart';

sealed class MailConState {
  const MailConState();
}

final class MailConInitial extends MailConState {
  const MailConInitial();
}

final class MailConSucceded extends MailConState {
  const MailConSucceded();
}

final class MailConFailed extends MailConState {
  const MailConFailed();
}