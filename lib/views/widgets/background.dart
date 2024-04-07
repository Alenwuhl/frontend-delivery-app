import 'package:flutter/material.dart';

class BackgroundStyle extends StatelessWidget {
  final bool useRadialGradient;
  const BackgroundStyle({super.key, this.useRadialGradient = false});

  @override
  Widget build(BuildContext context) {
    const linearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(82, 252, 242, 0.43),
        Color.fromRGBO(201, 137, 211, 0.98),
      ],
    );

    const radialGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.9,
      colors: [
        Color.fromRGBO(236, 162, 233, 0.43),
        Color.fromRGBO(137, 158, 211, 1),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        //to switch between the gradients
        gradient: useRadialGradient ? radialGradient : linearGradient,
      ),
    );
  }
}
