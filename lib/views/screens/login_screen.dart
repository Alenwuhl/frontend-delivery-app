import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/buttons/social_sign_in_button.dart';
import 'package:frontend_delivery_app/views/widgets/forms/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    const double imageSizeRatio = 0.4;
    const double logoSizeRatio = 0.7;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          Positioned(
            top: screenHeight *
                0.0, 
            left:
                10, 
            child: Image.asset(
              'assets/images/background_images/x_donut.png',
              width: screenWidth * imageSizeRatio,
              height: screenHeight * imageSizeRatio,
            ),
          ),
          Positioned(
            top:
                screenHeight * 0.02, 
            right: screenWidth * -0.05,
            child: Image.asset(
              'assets/images/background_images/donut.png',
              width: screenWidth * imageSizeRatio,
              height: screenHeight * imageSizeRatio,
            ),
          ),
          Positioned(
            top: screenHeight * 0.50,
            left: screenWidth * -0.2,
            child: Image.asset(
              'assets/images/logo.png',
              width: screenWidth * logoSizeRatio,
              height: screenHeight * logoSizeRatio,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.3),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Login to your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: LoginForm(),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Or sign in with',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SocialSignInButtons(),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: screenHeight *
                  0.95, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/register');
                    },
                    child: const Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 5, 5), 
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
