import 'package:firebase_auth/firebase_auth.dart';
// For Google sign-In:
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> createUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      // Registro exitoso
      print('User registered successfully');
      return true;
    } catch (e) {
      // Aquí podrías manejar diferentes tipos de errores y devolver mensajes de error específicos
      print('Error registering user: $e');
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      // Inicio de sesión con Facebook y obtención del AccessToken
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Si el usuario cancela el inicio de sesión, se retorna false
      if (loginResult.status != LoginStatus.success) return false;

      // Creación de una credencial para Firebase Auth
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Inicio de sesión en Firebase con la credencial de Facebook
      await _firebaseAuth.signInWithCredential(facebookAuthCredential);

      return true;
    } catch (e) {
      print('Error signing in with Facebook: $e');
      return false;
    }
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await FacebookAuth.instance.logOut();
  }
}


class GoogleAuthenticationService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print('Error signing in with Google: $e');
      return false;
    }
  }
}



