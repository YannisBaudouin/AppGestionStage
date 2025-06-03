import 'package:app_gestion_stage/app_page.dart';
import 'customWidget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'global_var.dart' as global;
import 'customWidget/custom_buttons.dart';

class MailConnexionPage extends StatefulWidget {
  const MailConnexionPage({super.key, required this.title});

  final String title;

  @override
  State<MailConnexionPage> createState() => MailConnexionPageState();
}

class MailConnexionPageState extends State<MailConnexionPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              pressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AppPage(title: 'AppPage'),
                      ),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  final String errorMsg = e.message ?? "Erreur inconnue";

                  showDialog<String>(
                    context: context,
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
                }
              },
              context: context,
            ),
            CustomEB(
              text: "Retour",
              pressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
