import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRegisterService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      // Handle successful registration
      // Possibly navigate to a different screen
    } catch (error) {
      // Handle errors such as email already in use
      print('Error registering user: $error');
      // Consider using something like Fluttertoast for better error handling
    }
  }
}
