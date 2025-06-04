import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mail_insc_bloc.dart';

import 'package:app_gestion_stage/customWidget/custom_widget.dart';

class MailInscriptionPage extends StatelessWidget {
  const MailInscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MailInscBloc(),
      child: MailInscriptionView(),
    );
  }
}

class MailInscriptionView extends StatelessWidget {
  MailInscriptionView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordVerificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailInscBloc, MailInscState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ADRESSE MAIL
                Container(
                  width: 300,
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    controller: emailController,
                    onChanged: (String text) =>
                        context.read<MailInscBloc>().add(
                          MailInscInputsChanged(
                            email: emailController.text,
                            password: passwordController.text,
                            passwordCheck: passwordVerificationController.text
                          ),
                        ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Adresse Courriel",
                      hintText: 'roger.figman@agestage.com',
                      errorText:
                          !context.select((MailInscBloc bloc) => bloc.mailValid)
                          ? "L'adresse Courriel n'est pas valide."
                          : null,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                // Mot de passe
                Container(
                  width: 300,
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    controller: passwordController,
                    onChanged: (String text) =>
                        context.read<MailInscBloc>().add(
                          MailInscInputsChanged(
                            email: emailController.text,
                            password: passwordController.text,
                            passwordCheck: passwordVerificationController.text
                          ),
                        ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mot de passe",
                      hintText: '*********',
                      helperText:
                          "Le mot de passe doit contenir au moins 6 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial.",
                      helperMaxLines: 6,
                      errorText:
                          !context.select((MailInscBloc bloc) => bloc.passwordValid)
                          ? "Le mot de passe doit contenir au moins 6 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial."
                          : null,
                      errorMaxLines: 6,
                      suffixIcon: IconButton(
                        onPressed: () => context.read<MailInscBloc>().add(
                          MailInscHidePassword(),
                        ),
                        icon: Icon(context.select((MailInscBloc bloc) => bloc.passwordHidden) ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_sharp),
                      ),
                    ),
                    // Cache le texte
                    obscureText: context.select((MailInscBloc bloc) => bloc.passwordHidden),
                  ),
                ),

                // Mot de passe Confirmer
                Container(
                  width: 300,
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    controller: passwordVerificationController,
                    onChanged: (String text) =>
                        context.read<MailInscBloc>().add(
                          MailInscInputsChanged(
                            email: emailController.text,
                            password: passwordController.text,
                            passwordCheck: passwordVerificationController.text
                          ),
                        ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmation du mot de passe",
                      hintText: '*********',
                      errorText:
                          !context.select((MailInscBloc bloc) => bloc.passwordVerifValid)
                          ? "Les mots de passes ne correspondent pas."
                          : null,
                      errorMaxLines: 2,
                    ),
                    // Cache le texte
                    obscureText: true,
                  ),
                ),

                // Bouton Inscription
                CustomEB(
                  text: "Inscription",
                  pressed: () async {
                    context.read<MailInscBloc>().add(
                      MailInscLogin(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      ),
                    );
                  },
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
