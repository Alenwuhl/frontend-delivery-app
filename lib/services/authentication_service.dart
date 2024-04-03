// authentication_service.dart
import 'package:firebase_auth/firebase_auth.dart';

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
}
