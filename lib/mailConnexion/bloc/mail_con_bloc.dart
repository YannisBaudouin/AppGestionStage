import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_gestion_stage/app_page.dart';

part 'mail_con_event.dart';
part 'mail_con_state.dart';

class MailConBloc extends Bloc<MailConEvent, MailConState> {
  MailConBloc() : super(const MailConInitial()) {
    on<MailConLogin>(_onLoginAttempt);
  }

  void _onLoginAttempt(MailConLogin event, Emitter<MailConState> emit) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(event.context).push(
          MaterialPageRoute(
            builder: (context) => const AppPage(title: 'AppPage'),
          ),
        );
      }

      emit(MailConSucceeded());
    } on FirebaseAuthException catch (e) {
      final String errorMsg = e.message ?? "Erreur inconnue";

      showDialog<String>(
        context: event.context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Problème lors de la connexion'),
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

      emit(MailConFailed());
    }
  }
}
