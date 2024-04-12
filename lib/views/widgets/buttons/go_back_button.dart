import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/authentication_service.dart';
import 'package:frontend_delivery_app/views/screens/home_screen.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
      color: Colors.black,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
