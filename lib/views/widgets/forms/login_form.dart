import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/authentication_service.dart';
import 'package:frontend_delivery_app/views/widgets/forms/forms_styles.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  Future<void> _tryLogin() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formKey.currentState?.save();
    try {
      bool loggedIn = await AuthenticationService()
          .signInWithEmailPassword(_email, _password);
      if (loggedIn) {
        Navigator.of(context).pushReplacementNamed('/timer');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: containerDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: inputDecoration.copyWith(
                  labelText: 'Email ',
                  hintText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
                onSaved: (value) => _email = value ?? '',
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: inputDecoration.copyWith(
                  labelText: 'Password',
                  hintText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
                onSaved: (value) => _password = value ?? '',
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                  height: 20),
                  
              Container(
                  decoration: gradientButtonDecoration,
                  child: ElevatedButton(
                    onPressed: _tryLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 252, 255, 0.53),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 95, vertical: 18),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                          color: Color.fromARGB(255, 5, 5, 5), fontSize: 16),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
