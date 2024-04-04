import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend_delivery_app/services/authentication_service.dart';

class SocialSignInButtons extends StatelessWidget {
  final AuthenticationService authService = AuthenticationService();

  SocialSignInButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.google),
          onPressed: () async {
            // Llama a tu método para iniciar sesión con Google
            await GoogleAuthenticationService.signInWithGoogle();
          },
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.facebook),
          onPressed: () async {
            // Llama a tu método para iniciar sesión con Facebook
            await authService.signInWithFacebook();
          },
        ),
      //   IconButton(
      //     icon: FaIcon(FontAwesomeIcons.twitter),
      //     onPressed: () async {
      //       // Llama a tu método para iniciar sesión con Twitter
      //       await authService.signInWithTwitter();
      //     },
      //   ),
      ],
    );
  }
}
