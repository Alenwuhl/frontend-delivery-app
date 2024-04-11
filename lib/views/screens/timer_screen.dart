import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/timer_widget.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Random number between 5 and 10
    int randomTimeInSeconds = (Random().nextInt(1) + 3) * 60;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackgroundStyle(useRadialGradient: true),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            child: TimerWidget(initialTime: randomTimeInSeconds),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset(
              'assets/images/loader.png', 
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.25,
            child: const Text(
              'LOADING...',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
