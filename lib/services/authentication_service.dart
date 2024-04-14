import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
// For Google sign-in
import 'package:google_sign_in/google_sign_in.dart';
// For Facebook sign-in
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


import 'package:flutter/foundation.dart';


class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Method to create a user with email and password
  Future<bool> createUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      // get the token
      String? token = await userCredential.user?.getIdToken();

      // get the uderId
      String userId = userCredential.user?.uid ?? '';

      // Save user information for future cart
      if (token != null) {
        await _saveUserData(email, token, userId);
      }
      return true;
    } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
    } else if (e.code == 'invalid-email') {
    } 
    return false;
  } catch (e) {
    return false;
  }
}

  // Method to sign in with email and password
  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      // get the token
      String? token = await userCredential.user?.getIdToken();

      // get the uderId
      String userId = userCredential.user?.uid ?? '';

      // Save user information for future cart
      if (token != null) {
        await _saveUserData(email, token, userId);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      } else if (e.code == 'wrong-password') {
        return false;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  // Method to save the information on sharedPreferences
  Future<void> _saveUserData(String email, String token, String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setString('auth_token', token);
    await prefs.setString('user_id', userId);
  }

  //Method to get the token
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Method to get userId
  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_email');
    await prefs.remove('user_id');
  }


  // Method to sign in with Twitter
Future<bool> signInWithTwitter() async {
  TwitterAuthProvider twitterProvider = TwitterAuthProvider();

  if (kIsWeb) {
    await FirebaseAuth.instance.signInWithPopup(twitterProvider);
    return true;
  } else {
    await FirebaseAuth.instance.signInWithProvider(twitterProvider);
    return false;
  }
}

  // Method to sign out
  Future<void> socialSignOut() async {
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
  }
}

//Class for signin with google
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
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      String? token = await userCredential.user?.getIdToken();
      String? email = userCredential.user?.email;
      String? userId = userCredential.user?.uid;

      if (token != null && email != null && userId != null) {
        await _saveUserData(email, token, userId);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to save the information on sharedPreferences
  static Future<void> _saveUserData(
      String email, String token, String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setString('auth_token', token);
    await prefs.setString('user_id', userId);
  }
}
