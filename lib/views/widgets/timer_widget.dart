import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/Cart/cart_provider.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatefulWidget {
  final int initialTime;

  const TimerWidget({super.key, required this.initialTime});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int _remainingTime;
  Timer? _timer;
  bool _hasTimerFinished = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.initialTime;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remainingTime > 0) {
        setState(() => _remainingTime--);
      } else {
        setState(() {
          _hasTimerFinished = true;
          timer.cancel(); // Cancela el timer cuando el tiempo se agota
          // Llama a clearCart() aquí dentro de setState para asegurar la sincronía
          if (context.read<CartProvider>().cartItemsList.isNotEmpty) {
            context.read<CartProvider>().clearCart();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _hasTimerFinished
          ? const Text(
            'Your delivery has arrived!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          )
          : Text(
            _formatRemainingTime(),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }

  String _formatRemainingTime() {
    int minutes = _remainingTime ~/ 60;
    int seconds = _remainingTime % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
