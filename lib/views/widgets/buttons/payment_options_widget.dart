// import 'package:provider/provider.dart';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:frontend_delivery_app/models/cart_model.dart';
// import 'package:frontend_delivery_app/services/Cart/cart_provider.dart';
// import 'package:frontend_delivery_app/views/screens/cart_screen.dart';

// class PaymentOptionsWidget extends StatelessWidget {
//   final String productId;
//   final String productTitle;
//   final String productImageUrl;
//   final double productPrice;
//   final List<String> selectedExtras;
//   final List<String> selectedExtrasTitles;
//   final List<double> selectedExtrasPrices;

//   const PaymentOptionsWidget({
//     super.key,
//     required this.productId,
//     required this.productTitle,
//     required this.productImageUrl,
//     required this.productPrice,
//     required this.selectedExtras,
//     required this.selectedExtrasTitles,
//     required this.selectedExtrasPrices,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildPaymentOption(
//           context,
//           'assets/images/payment_images/pay_here.png',
//           'Pay Here',
//           () {
//             // Add Cart Item and navigate to CartScreen if not empty
//             _addToCartAndNavigate(context, addToCart: true);
//           },
//         ),
//         _buildPaymentOption(
//           context,
//           'assets/images/payment_images/buy_continue.png',
//           'Continue Shopping',
//           () {
//             // Just add to Cart without navigation
//             _addToCartAndNavigate(context, addToCart: false);
//           },
//         ),
//       ],
//     );
//   }

//   GestureDetector _buildPaymentOption(BuildContext context, String imagePath, String label, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Image.asset(imagePath, width: 100, height: 100),
//           Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
//         ],
//       ),
//     );
//   }

//   void _addToCartAndNavigate(BuildContext context, {required bool addToCart}) {
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     cartProvider.addCartItem(
//       CartItem(
//         cartItemId: Random().nextInt(1000000),
//         productId: productId,
//         productTitle: productTitle,
//         productImageUrl: productImageUrl,
//         productPrice: productPrice,
//         selectedExtras: selectedExtras,
//         selectedExtrasTitles: selectedExtrasTitles,
//         selectedExtrasPrices: selectedExtrasPrices,
//       ),
//     );
//     if (addToCart && cartProvider.cartItemsList.isNotEmpty) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
//     }
//   }
// }
