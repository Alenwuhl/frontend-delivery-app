import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/models/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:frontend_delivery_app/services/Cart/cart_provider.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final int quantity;

  const CartItemCard({
    super.key,
    required this.cartItem,
    this.quantity = 1,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(cartItem.productImageUrl),
              radius: 30.0,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.productTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '\$${cartItem.cartItemPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Wrap(
                    spacing: 5.0, 
                    children: cartItem.selectedExtrasTitles
                        .asMap()
                        .map((i, title) => MapEntry(
                              i,
                              Text(
                                i < cartItem.selectedExtrasTitles.length - 1
                                    ? '$title, '
                                    : title, 
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ))
                        .values
                        .toList(),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: () {
                    cartProvider.modifyCartItemQuantity(cartItem.cartItemId, 1);
                  },
                ),
                Text('${cartItem.quantity}'),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red),
                  onPressed: () {
                    if (cartItem.quantity > 1) {
                      cartProvider.modifyCartItemQuantity(
                          cartItem.cartItemId, -1);
                    }
                  },
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.blue),
              onPressed: () {
                cartProvider.removeCartItem(cartItem.cartItemId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
