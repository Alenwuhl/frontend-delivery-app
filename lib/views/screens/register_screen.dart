import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/views/widgets/forms/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}
