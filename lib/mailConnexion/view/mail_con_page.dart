import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mail_con_bloc.dart';

import 'package:app_gestion_stage/customWidget/custom_widget.dart';

class MailConnexionPage extends StatelessWidget {
  const MailConnexionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MailConBloc(),
      child: const MailConnexionView(),
    );
  }
}

class MailConnexionView extends StatelessWidget {
  const MailConnexionView({super.key});

  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailConBloc, MailConState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ADRESSE MAIL
                SizedBox(
                  width: 250,
                  child: CustomTF(
                    labelText: "Adresse",
                    controller: emailController,
                    context: context,
                    hintText: "Adresse couriel*",
                    helperText: "Votre adresse Couriel doit être valide",
                    cacher: false,
                  ),
                ),
                // Mot de passe
                SizedBox(
                  width: 250,
                  child: CustomTF(
                    labelText: "Mot de passe",
                    controller: passwordController,
                    context: context,
                    hintText: "Mot de passe*",
                    helperText: null,
                    cacher: true,
                  ),
                ),
                CustomEB(
                  text: "Connexion",
                  pressed: () => context.read<MailConBloc>().add(
                    MailConLogin(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context,
                    ),
                  ),
                  context: context,
                ),
                CustomEB(
                  text: "Retour",
                  pressed: () {
                    Navigator.pop(context);
                  },
                  context: context,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
