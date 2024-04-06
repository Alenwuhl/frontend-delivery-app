import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/authentication_service.dart';


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
  print('1');
  if (!isValid) return;
  print('2');
  
  _formKey.currentState?.save();
  print('3');
  try {
    bool loggedIn = await AuthenticationService().signInWithEmailPassword(_email, _password);
    print('4');
    String? token = await AuthenticationService().getToken();
    print('5');
    print(token);
    if (loggedIn) {

      Navigator.of(context).pushReplacementNamed('/categories');
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
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email.';
              }
              return null;
            },
            onSaved: (value) => _email = value ?? '',
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 6) {
                return 'Password must be at least 6 characters long.';
              }
              return null;
            },
            onSaved: (value) => _password = value ?? '',
          ),
          ElevatedButton(onPressed: _tryLogin, child: const Text('Login'))
        ],
      ),
    );
  }
}
