import 'package:app_gestion_stage/app_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'global_var.dart' as global;

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
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Adresse Courriel*',
                  helperText:"Votre adresse Courriel doit être valide",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            // Mot de passe
            SizedBox(
              width: 250,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mot de passe*',
                ),
                // Cache le texte
                obscureText: true,
              ),
            ),
            ElevatedButton(onPressed: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                if (FirebaseAuth.instance.currentUser != null) {
                  
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AppPage(title: 'AppPage',)),
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
            }, child: Text("Connexion")),
            ElevatedButton(onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
            }, child: Text("Retour")),
          ],
        ),
      ),
    );
  }
}