import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend_delivery_app/views/widgets/buttons/register_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  void _trySubmitForm() {
    print('Trying to submit form');
    final isValid = _formKey.currentState!.validate();
    print('Is form valid? $isValid'); // Depuración para verificar si el formulario es válido
    
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      print('Form saved'); // Confirma que el estado del formulario se ha guardado
      print('Password: $_password');
      print('Confirm Password: $_confirmPassword');

      if (_password != _confirmPassword) {
        print('Passwords do not match'); // Depuración adicional en caso de que las contraseñas no coincidan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Passwords do not match.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        return; // Sale temprano si las contraseñas no coinciden
      }

      // Si las contraseñas coinciden, utiliza Firebase Authentication para registrar al usuario
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      ).then((userCredential) {
        // TODO: Manejar el registro exitoso
        print('User registered successfully');
      }).catchError((error) {
        // TODO: Manejar errores, como email ya en uso
        print('Error registering user: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            key: const ValueKey('email'),
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email address.';
              }
              return null;
            },
            onSaved: (value) => _email = value ?? '',
            decoration: const InputDecoration(labelText: 'Email Address'),
          ),
          TextFormField(
            key: const ValueKey('password'),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return 'Password must be at least 6 characters long.';
              }
              return null;
            },
            onSaved: (value) => _password = value ?? '',
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          TextFormField(
            key: const ValueKey('confirm_password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirm password is required.';
              }
              // No es necesario comparar aquí, ya que lo hacemos después del save
              return null;
            },
            onSaved: (value) => _confirmPassword = value ?? '',
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
          ),
          RegisterButton(onPressed: _trySubmitForm),
        ],
      ),
    );
  }
}
