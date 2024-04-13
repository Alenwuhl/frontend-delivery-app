import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/forms/register_form.dart';
import 'package:frontend_delivery_app/views/widgets/buttons/social_sign_in_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    const double topPaddingRatio = 0.25; 
    const double sidePaddingRatio = 0.1; 
    const double betweenElementsRatio = 0.03;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * topPaddingRatio,
                horizontal: screenWidth * sidePaddingRatio,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create your Account',
                    style: TextStyle(
                      fontSize: screenHeight * 0.04, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * betweenElementsRatio),
                  const RegisterForm(), 
                  SizedBox(height: screenHeight * betweenElementsRatio),
                  SocialSignInButtons(), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}