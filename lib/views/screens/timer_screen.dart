import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/Cart/cart_provider.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/cards/order_summary_card.dart';
import 'package:frontend_delivery_app/views/widgets/timer_widget.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItemsList;
    final totalAmount = cartProvider.totalAmount;
    // Random number between 1 and 3 for the timer 
    int randomTimeInSeconds = (Random().nextInt(1) + 3) * 60;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackgroundStyle(useRadialGradient: true),
          Column(
            children: [
              Expanded(
                flex: 3, 
                child: OrderSummaryWidget(cartItems: cartItems, totalAmount: totalAmount),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    TimerWidget(initialTime: randomTimeInSeconds),
                    Image.asset(
                      'assets/images/loader.png', 
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    const Text(
                      'LOADING...',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
