import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/authentication_service.dart';

class SocialSignInButtons extends StatelessWidget {
  final AuthenticationService authService = AuthenticationService();

  SocialSignInButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSocialButton(
          context,
          imagePath: 'assets/images/social_icons/google_icon.png',
          onTap: () async {
            bool loggedIn =
                await GoogleAuthenticationService.signInWithGoogle();
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
          },
        ),
        _buildSocialButton(
          context,
          imagePath: 'assets/images/social_icons/facebook_icon.png',
          onTap: () async {
            // await authService.signInWithFacebook();
          },
        ),
        _buildSocialButton(
          context,
          imagePath: 'assets/images/social_icons/twitter_icon.png',
          onTap: () async {
            var authService = AuthenticationService();
            bool loggedIn = await authService.signInWithTwitter();
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
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton(BuildContext context,
      {required String imagePath, required VoidCallback onTap}) {
    double size = MediaQuery.of(context).size.width * 0.12;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
