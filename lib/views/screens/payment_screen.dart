import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _donut1Animation;
  late Animation<Offset> _donut2Animation;
  late Animation<Offset> _donut3Animation;
  bool _imageTappedOnce = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _donut1Animation = Tween<Offset>(
      begin: const Offset(1.0, 3.0), // La dona comienza en su posición original
      end: const Offset(
          0.8, 0.8), // Mueve la dona de abajo derecha a arriba derecha
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

_donut2Animation = Tween<Offset>(
  begin: const Offset(-0.7, 0.0), // Empieza ligeramente fuera de la pantalla por la izquierda
  end: const Offset(-0.3, 0.0), // Se mueve hacia la derecha pero sigue en la parte superior
).animate(
  CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
  ),
);

_donut3Animation = Tween<Offset>(
  begin: const Offset(-1.0, 4.0), // Comienza fuera de la pantalla, abajo a la izquierda
  end: const Offset(0.0, 4.0), // Termina mucho más abajo de la pantalla, abajo a la izquierda
).animate(
  CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
  ),
);



  }

  void _onTap() {
    if (_imageTappedOnce) {
      Navigator.pushNamed(context, '/timer');
    } else {
      _animationController.forward();
      setState(() {
        _imageTappedOnce = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final centralImageSize =
        screenWidth * 0.4; // Example size, 40% of screen width

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: true),
          SlideTransition(
            position: _donut1Animation,
            child: Positioned(
              top: 0,
              right: 0,
              child: Image.asset('assets/images/background_images/donut.png'),
            ),
          ),
          SlideTransition(
            position: _donut2Animation,
            child: Positioned(
              left: 0,
              top: 0,
              child: Image.asset('assets/images/background_images/0_donut.png'),
            ),
          ),
          SlideTransition(
            position: _donut3Animation,
            child: Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset('assets/images/background_images/x_donut.png'),
            ),
          ),
          GestureDetector(
            onTap: _onTap,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _imageTappedOnce
                    ? Image.asset(
                        'assets/images/payment_images/payment_2.png',
                        key: const ValueKey('payment2'),
                        width: centralImageSize,
                        height: centralImageSize,
                      )
                    : Image.asset(
                        'assets/images/payment_images/payment_1.png',
                        key: const ValueKey('payment1'),
                        width: centralImageSize,
                        height: centralImageSize,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
