import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/authentication_service.dart';
import 'package:frontend_delivery_app/views/widgets/forms/forms_styles.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationService _authService = AuthenticationService();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  void _trySubmitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text('Passwords do not match.'),
              backgroundColor: Theme.of(context).colorScheme.error),
        );
        return;
      }

      bool result = await _authService.createUser(_email, _password);
      if (!result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text('Failed to register.'),
              backgroundColor: Theme.of(context).colorScheme.error),
        );
      } else {
        Navigator.of(context).pushReplacementNamed('/categories');
      }
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
            children: <Widget>[
              TextFormField(
                decoration:
                    inputDecoration.copyWith(labelText: "Email", hintText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                onSaved: (value) => _email = value ?? '',
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: inputDecoration.copyWith(
                    labelText: "Password", hintText: "Password"),
                key: const ValueKey('password'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
                onSaved: (value) => _password = value ?? '',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: inputDecoration.copyWith(
                    labelText: "Confirm password", hintText: "Confirm password"),
                key: const ValueKey('confirm_password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required.';
                  }
                  return null;
                },
                onSaved: (value) => _confirmPassword = value ?? '',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Container(
                  decoration: gradientButtonDecoration,
                  child: ElevatedButton(
                    onPressed: _trySubmitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 252, 255, 0.53),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 95, vertical: 18),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Color.fromARGB(255, 5, 5, 5), fontSize: 16),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
