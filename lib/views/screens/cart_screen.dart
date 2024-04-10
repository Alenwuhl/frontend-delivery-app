import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend_delivery_app/services/Cart/cart_provider.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/cards/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usa Provider.of para acceder a CartProvider en la jerarquía de widgets.
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "This is your order",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItemsList.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartProvider.cartItemsList[index];
                        return CartItemCard(
                          cartItem: cartItem,
                          // Añade aquí las funciones necesarias
                          // como callbacks para onAdd y onRemove si son necesarias.
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Esto centra el contenido de la columna verticalmente
                      children: [
                        Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            return Text(
                              'Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Implementa la funcionalidad para finalizar la compra
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              backgroundColor: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Finalize purchase',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
