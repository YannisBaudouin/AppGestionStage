part of 'mail_insc_bloc.dart';

sealed class MailInscEvent {
  const MailInscEvent();
}

final class MailInscLogin extends MailInscEvent {
  final String email;
  final String password;
  final BuildContext context;

  const MailInscLogin({required this.email, required this.password, required this.context});
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