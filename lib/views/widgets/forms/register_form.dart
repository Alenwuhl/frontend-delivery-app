import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/authentication_service.dart';
import 'package:frontend_delivery_app/views/widgets/buttons/register_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
          SnackBar(content: const Text('Passwords do not match.'), backgroundColor: Theme.of(context).colorScheme.error),
        );
        return;
      }

      bool result = await _authService.createUser(_email, _password);
      if (!result) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          // ignore: use_build_context_synchronously
          SnackBar(content: const Text('Failed to register.'), backgroundColor: Theme.of(context).colorScheme.error),
        );
      } else {
        // Aquí puedes redirigir al usuario o manejar el éxito del registro como prefieras
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed('/home'); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
