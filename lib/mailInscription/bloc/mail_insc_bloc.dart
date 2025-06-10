import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_gestion_stage/app_page.dart';

import 'package:app_gestion_stage/class/appUser.dart';

part 'mail_insc_event.dart';
part 'mail_insc_state.dart';

class MailInscBloc extends Bloc<MailInscEvent, MailInscState> {
  MailInscBloc() : super(const MailInscInitial()) {
    on<MailInscLogin>(_onLoginAttempt);
    on<MailInscInputsChanged>(_checkInputsValid);
    on<MailInscHidePassword>(_hidePassword);
  }

  bool passwordHidden = true;

  bool mailValid = false;
  bool passwordValid = false;
  bool passwordVerifValid = false;

  void _hidePassword(MailInscHidePassword event, Emitter<MailInscState> emit) {
    passwordHidden = !passwordHidden;
    emit(MailInscInitial());
  }

  void _checkInputsValid(MailInscInputsChanged event, Emitter<MailInscState> emit) {
    mailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(event.email);

    passwordValid = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$',
      ).hasMatch(event.password);

    passwordVerifValid = event.password == event.passwordCheck;

    emit(MailInscInitial());
  }

  void _onLoginAttempt(MailInscLogin event, Emitter<MailInscState> emit) async {
    try {
      UserCredential userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

      AppUser user = AppUser(
        userCredentials.user!.uid,
        userCredentials.user!.email,
        "",
        "",
        DateTime.now(),
        "Eleve",
        "",
        "",
        "",
        [],
      );
      user.update();

      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(event.context).push(
          MaterialPageRoute(
            builder: (context) => const AppPage(title: 'AppPage'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      final String errorMsg = e.message ?? "Erreur inconnue";

      showDialog<String>(
        context: event.context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Problème lors de l\'inscription'),
          content: Text(errorMsg),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.popUntil(
                context,
                ModalRoute.withName(Navigator.defaultRouteName),
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
