import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  static late User? user;

  static init() {
    user = FirebaseAuth.instance.currentUser;

    FirebaseAuth.instance.authStateChanges().listen((User? user_) {
      user = user_;
    });
  }
}
