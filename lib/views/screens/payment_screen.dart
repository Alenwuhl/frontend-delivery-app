import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _donut1Animation;
  late Animation<Offset> _donut2Animation;
  bool _imageTappedOnce = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

_donut1Animation = Tween<Offset>(
  begin: const Offset(1.0, -1.0), // Comienza desde la parte superior derecha (x positiva, y negativa)
  end: const Offset(-1.0, 1.0), // Termina en la parte inferior izquierda (x negativa, y positiva)
).animate(
  CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut, // Este es el tipo de interpolación de la animación, puedes cambiarla como desees
  ),
);


    _donut2Animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(_animationController);
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
    final centralImageSize = screenWidth * 0.3; // Example size, 30% of screen width

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: true),
          SlideTransition(
            position: _donut1Animation,
            child: Image.asset('assets/images/background_images/donut.png'),
          ),
          SlideTransition(
            position: _donut2Animation,
            child: Image.asset('assets/images/background_images/0_donut.png'),
          ),
          if (_imageTappedOnce)
            Positioned(
              child: Image.asset('assets/images/background_images/x_donut.png'),
            ),
          GestureDetector(
            onTap: _onTap,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _imageTappedOnce
                    ? Image.asset(
                        'assets/images/payment_images/payment_2.png',
                        key: const ValueKey('central2'),
                        width: centralImageSize,
                        height: centralImageSize,
                      )
                    : Image.asset(
                        'assets/images/payment_images/payment_1.png',
                        key: const ValueKey('central1'),
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
