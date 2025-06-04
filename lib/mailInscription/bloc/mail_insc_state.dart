part of 'mail_insc_bloc.dart';

sealed class MailInscState {
  const MailInscState();
}

final class MailInscInitial extends MailInscState {
  const MailInscInitial();
}

final class MailInscSucceeded extends MailInscState {
  const MailInscSucceeded();
}

final class MailInscFailed extends MailInscState {
  const MailInscFailed();
}