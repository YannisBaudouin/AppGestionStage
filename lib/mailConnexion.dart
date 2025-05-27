import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
               await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
               
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