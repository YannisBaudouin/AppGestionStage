part of 'mail_con_bloc.dart';

sealed class MailConEvent {
  const MailConEvent();
}

final class MailConLogin extends MailConEvent {
  final String email;
  final String password;
  final BuildContext context;

  const MailConLogin({required this.email, required this.password, required this.context});
}