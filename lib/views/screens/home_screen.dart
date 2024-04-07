import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    const double imageWidthRatio = 0.95;
    const double imageHeightRatio = 0.95;
    const double fontSizeRatio = 0.045;

    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
        child: Stack(
          children: [
            const BackgroundStyle(useRadialGradient: true),
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'The fastest food delivery service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenHeight * fontSizeRatio,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 5, 5, 5),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3, 
                  child: Image.asset(
                    'assets/images/logo.png', 
                    width: screenWidth * imageWidthRatio,
                    height: screenHeight * imageHeightRatio,
                  ),
                ),
                const Spacer(), 
              ],
            ),
          ],
        ),
      ),
    );
  }
}
