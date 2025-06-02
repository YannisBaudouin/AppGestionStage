import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'class/appUser.dart';

class MailInscriptionPage extends StatefulWidget {
  const MailInscriptionPage({super.key, required this.title});

  final String title;

  @override
  State<MailInscriptionPage> createState() => MailInscriptionPageState();
}

class MailInscriptionPageState extends State<MailInscriptionPage> {
  bool mailValid = true;
  bool passwordValid = true;
  bool passwordVerificationValid = true;

  bool passwordHidden = true;
  IconData currentPasswordSuffixIcon = Icons.remove_red_eye_outlined;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordVerificationController =
      TextEditingController();

  void updateEmailValid(text) {
    setState(() {
      mailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(emailController.text);
    });
  }

  void updatePasswords(text) {
    setState(() {
      passwordValid = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$',
      ).hasMatch(passwordController.text);
      passwordVerificationValid =
          passwordController.text == passwordVerificationController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onChanged: updateEmailValid,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Adresse Courriel",
                  hintText: 'roger.figman@agestage.com',
                  errorText: !mailValid
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
                onChanged: updatePasswords,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Mot de passe",
                  hintText: '*********',
                  helperText:
                      "Le mot de passe doit contenir au moins 6 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial.",
                  helperMaxLines: 6,
                  errorText: !passwordValid
                      ? "Le mot de passe doit contenir au moins 6 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial."
                      : null,
                  errorMaxLines: 6,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      passwordHidden = !passwordHidden;

                      if (passwordHidden) {
                        currentPasswordSuffixIcon =
                            Icons.remove_red_eye_outlined;
                      } else {
                        currentPasswordSuffixIcon = Icons.remove_red_eye_sharp;
                      }
                    }),
                    icon: Icon(currentPasswordSuffixIcon),
                  ),
                ),
                // Cache le texte
                obscureText: passwordHidden,
              ),
            ),

            // Mot de passe Confirmer
            Container(
              width: 300,
              margin: const EdgeInsets.all(5),
              child: TextField(
                controller: passwordVerificationController,
                onChanged: updatePasswords,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Confirmation du mot de passe",
                  hintText: '*********',
                  errorText: !passwordVerificationValid
                      ? "Les mots de passes ne correspondent pas."
                      : null,
                  errorMaxLines: 2,
                ),
                // Cache le texte
                obscureText: true,
              ),
            ),

            // Bouton Inscription
            ElevatedButton(
              onPressed: () async {
                updateEmailValid("");
                updatePasswords('');
                if (mailValid && passwordValid && passwordVerificationValid) {
                  try {
                    UserCredential userCredentials = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        
                    AppUser user = new AppUser(userCredentials.user!.uid, "", "", DateTime.now(), "Eleve", "", "", "");
                    user.update();

                  } on FirebaseAuthException catch (e) {
                    final String errorMsg = e.message ?? "Erreur inconnue";

                    showDialog<String>(
                      context: context,
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
              },
              child: Text("Inscription"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
              },
              child: Text("Retour"),
            ),
          ],
        ),
      ),
    );
  }
}
