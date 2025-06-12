part of 'mail_insc_bloc.dart';

sealed class MailInscEvent {
  const MailInscEvent();
}

final class MailInscLogin extends MailInscEvent {
  final String email;
  final String password;

  final String fName;
  final String lName;
  final DateTime birthDate;

  final BuildContext context;

  const MailInscLogin({required this.fName, required this.lName, required this.birthDate, required this.email, required this.password, required this.context});
}

final class MailInscInputsChanged extends MailInscEvent {
  final String email;
  final String password;
  final String passwordCheck;

  const MailInscInputsChanged({required this.email, required this.password, required this.passwordCheck});
}

final class MailInscHidePassword extends MailInscEvent {
  const MailInscHidePassword();
}

final class MailInscAcceptLegal extends MailInscEvent {
  final bool value;
  const MailInscAcceptLegal({required this.value});
}