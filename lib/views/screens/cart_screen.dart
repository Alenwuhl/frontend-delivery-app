import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/order_service.dart';
import 'package:provider/provider.dart';
import 'package:frontend_delivery_app/services/Cart/cart_provider.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/cards/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          Positioned(
            right: -screenWidth * 0.25,
            bottom: screenHeight * 0.1,
            child: Image.asset(
              'assets/images/background_images/donut.png',
              width: screenWidth * 0.5,
              height: screenHeight * 0.5,
            ),
          ),
          Positioned(
            right: screenWidth * 0.3,
            top: screenHeight * 0.05,
            child: Image.asset(
              'assets/images/background_images/x_donut.png',
              width: screenWidth * 1.4,
              height: screenHeight * 1.6,
            ),
          ),
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
                              onPressed: () async {
                                final cartProvider = Provider.of<CartProvider>(
                                    context,
                                    listen: false);
                                final orderService = OrderService();
                                try {
                                  final response =
                                      await orderService.createOrder(
                                    cartProvider.cartItemsList,
                                    cartProvider.totalAmount,
                                  );
                                  if (response.statusCode == 200) {
                                    // En caso de éxito, limpiar el carrito.
                                    cartProvider.clearCart();
                                    // Navegar a la pantalla de pago.
                                    Navigator.of(context)
                                        .pushReplacementNamed('/payment');
                                  } else {
                                    // En caso de error, mostrar un mensaje.
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              'There was an error placing the order. Please try again.'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Close'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } catch (e) {
                                  // En caso de excepción, mostrar un mensaje.
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: Text(
                                            'An unexpected error occurred: $e'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Confirm and pay'),
                            )),
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
