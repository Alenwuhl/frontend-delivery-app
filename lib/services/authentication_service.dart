import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// For Google sign-in
import 'package:google_sign_in/google_sign_in.dart';
// For Facebook sign-in
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// For X sign-in
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';


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

//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
  // Method to sign in with Twitter
  Future<bool> signInWithTwitter() async {
  try {
    final TwitterLogin twitterLogin = TwitterLogin(
      apiKey: 'SDRCnttcSDQgqzGbgEOCRELIC',
      apiSecretKey: 'ZaO8RBCLOsSx6qJXvyfHBrUl3nHEhyJew7pKbhSqVA7TRoJoz7',
      redirectURI: 'https:futuristic-delivery-app.firebaseapp.com/__/auth/handler', 
    );

    final AuthResult authResult = await twitterLogin.loginV2();
    if (authResult.status == TwitterLoginStatus.loggedIn) {
      final response = await http.post(
        Uri.parse('https://tu-dominio.com/auth/twitter'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'token': authResult.authToken,
          'tokenSecret': authResult.authTokenSecret,
        }),
      );

      if (response.statusCode == 200) {
        // Maneja la respuesta de tu backend
        // Por ejemplo, guarda el token de sesión personalizado
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
  // Future<bool> signInWithTwitter() async {
  //   try {
  //     final TwitterLogin twitterLogin = TwitterLogin(
  //         apiKey: 'hPvSInVdAWGnRgg7h3Ph0OMju',
  //         apiSecretKey: 'G8yQ6gWKaW0EH4zEzjSMaoHP1lqitwfV0hkJgzAXNYGB02gEML',
  //         redirectURI:
  //             'socialAuth://' //'https://futuristic-delivery-app.firebaseapp.com/__/auth/handler'
  //         );

  //     final AuthResult authResult = await twitterLogin.loginV2();
  //     if (authResult.status == TwitterLoginStatus.loggedIn) {
  //       try {
  //         final AuthCredential credential = TwitterAuthProvider.credential(
  //           accessToken: authResult.authToken!,
  //           secret: authResult.authTokenSecret!,
  //         );
  //         await _firebaseAuth.signInWithCredential(credential);
  //         return true;
  //       } catch (e) {
  //         print("este try");
  //         print(e);
  //       }
  //     } else {
  //       print(authResult.status);
  //     }
      // switch (authResult.status) {
      //               case TwitterLoginStatus.loggedIn:
      //                 print('1');
      //                 break;
      //               case TwitterLoginStatus.cancelledByUser:
      //               print('2');
      //                 // cancel
      //                 break;
      //               case TwitterLoginStatus.error:
      //               print('3');
      //                 // error
      //                 break;
      //               default:
      //               print('4');
      //             }

  //     return false;
  //   } catch (e) {
  //     print('Error signing in with Twitter: $e');
  //     return false;
  //   }
  // }
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------

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
