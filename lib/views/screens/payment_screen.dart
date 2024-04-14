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
      begin: const Offset(1.0, 2.0),
      end: const Offset(0.8, 0.8),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _donut2Animation = Tween<Offset>(
      begin: const Offset(-0.7, 0.0),
      end: const Offset(-0.3, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _donut3Animation = Tween<Offset>(
      begin: const Offset(-1.0, 4.0),
      end: const Offset(0.0, 4.0),
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
    final centralImageSize = screenWidth * 0.4;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: true),
          buildSlideTransition(_donut1Animation, 'assets/images/background_images/donut.png', Alignment.topRight),
          buildSlideTransition(_donut2Animation, 'assets/images/background_images/0_donut.png', Alignment.topLeft),
          buildSlideTransition(_donut3Animation, 'assets/images/background_images/x_donut.png', Alignment.bottomLeft),
          buildCenterImageGestureDetector(centralImageSize),
        ],
      ),
    );
  }

  SlideTransition buildSlideTransition(Animation<Offset> animation, String imagePath, AlignmentGeometry alignment) {
    return SlideTransition(
      position: animation,
      child: Align(
        alignment: alignment,
        child: Image.asset(imagePath),
      ),
    );
  }

  GestureDetector buildCenterImageGestureDetector(double imageSize) {
    return GestureDetector(
      onTap: _onTap,
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _imageTappedOnce
              ? Image.asset(
                  'assets/images/payment_images/payment_2.png',
                  key: const ValueKey('payment2'),
                  width: imageSize,
                  height: imageSize,
                )
              : Image.asset(
                  'assets/images/payment_images/payment_1.png',
                  key: const ValueKey('payment1'),
                  width: imageSize,
                  height: imageSize,
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
