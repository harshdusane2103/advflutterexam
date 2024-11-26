import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
      static AuthServices authServices = AuthServices._();
      AuthServices._();

      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      Future<void> createAccount(String email, String password) async {
            await firebaseAuth.createUserWithEmailAndPassword(
                email: email, password: password);
      }

      Future<void> signIn(String email, String password) async {
            await firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password);
      }

      Future<void> logOut() async {
            await firebaseAuth.signOut();
      }
}