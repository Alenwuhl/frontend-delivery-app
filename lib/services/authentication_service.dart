import 'package:firebase_auth/firebase_auth.dart';
// For Google sign-in
import 'package:google_sign_in/google_sign_in.dart';
// For Facebook sign-in
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Method to create a user with email and password
  Future<bool> createUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      print('User registered successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
         return false;
      }
    } catch (e) {
      print('Error registering user: $e');
      return false;
    }
    return false;
  }

  // Method to sign in with email and password
  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      String? token = await userCredential.user?.getIdToken();
      print(token);
      if (token != null) {
        await _saveToken(token);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
         return false;
      }
    } catch (e) {
      print('Error registering user: $e');
      return false;
    }
    return false;
  }

  Future<void> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // Method to sign in with Facebook
  Future<bool> signInWithFacebook() async {
    try {
      final LoginResult loginResult =
          await FacebookAuth.instance.login(permissions: ["email"]);
      if (loginResult.status != LoginStatus.success) return false;
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      return true;
    } catch (e) {
      print('Error signing in with Facebook: $e');
      return false;
    }
  }

  // Method to sign out
  Future<void> socialSignOut() async {
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
  }
}

class GoogleAuthenticationService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

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
