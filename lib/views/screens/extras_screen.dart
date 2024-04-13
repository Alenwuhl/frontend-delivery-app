import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/models/cart_model.dart';
import 'package:frontend_delivery_app/services/extras_service.dart';
import 'package:frontend_delivery_app/views/screens/cart_screen.dart';
import 'package:frontend_delivery_app/services/Cart/cart_provider.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/buttons/go_back_button.dart';
import 'package:frontend_delivery_app/views/widgets/cards/extra_card.dart';
import 'package:frontend_delivery_app/views/widgets/cards/product_banner.dart';
import 'package:frontend_delivery_app/views/widgets/cards/selected_extras_widget.dart';
import 'package:provider/provider.dart';

class ExtrasScreen extends StatefulWidget {
  final String productId;
  final String productTitle;
  final String productImageUrl;
  final double productPrice;

  const ExtrasScreen({
    super.key,
    required this.productId,
    required this.productTitle,
    required this.productImageUrl,
    required this.productPrice,
  });

  @override
  _ExtrasScreenState createState() => _ExtrasScreenState();
}

class _ExtrasScreenState extends State<ExtrasScreen> {
  late final ExtrasService _extrasService;
  List<String> selectedExtras = [];
  List<String> selectedExtrasTitles = [];
  List<double> selectedExtrasPrices = [];
  List<String> selectedExtrasImages = [];

  @override
  void initState() {
    super.initState();
    _extrasService = ExtrasService();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double titleFontSize = screenHeight * 0.05;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          const Positioned(
            top: 20, 
            left: 20,
            child: BackButtonWidget(),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Text(
                    'You can order now',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SelectedExtrasWidget(
                  selectedExtrasImages: selectedExtrasImages,
                  selectedExtrasTitles: selectedExtrasTitles,
                  screenHeight: screenHeight * 0.2,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: screenHeight * 0.1,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: ProductBanner(
                    imageUrl: widget.productImageUrl,
                    title: widget.productTitle,
                    height: screenHeight * 0.15,
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: _extrasService.getExtrasProduct(widget.productId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        var extras = snapshot.data!;
                        return GridView.builder(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: screenWidth * 0.03,
                            mainAxisSpacing: screenHeight * 0.0,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: extras.length,
                          itemBuilder: (context, index) {
                            var extra = extras[index];
                            if (!selectedExtras.contains(extra['id'])) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExtraCard(
                                  imageUrl: extra['imageUrl'],
                                  title: extra['title'],
                                  price: extra['price'].toString(),
                                  onIconTap: () {
                                    setState(() {
                                      selectedExtras.add(extra['id']);
                                      selectedExtrasTitles.add(extra['title']);
                                      selectedExtrasPrices.add(extra['price']);
                                      selectedExtrasImages
                                          .add(extra['imageUrl']);
                                    });
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      } else {
                        return const Center(child: Text('No extras found'));
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        cartProvider.addCartItem(
                          CartItem(
                            cartItemId: Random().nextInt(1000000),
                            productId: widget.productId,
                            productTitle: widget.productTitle,
                            productImageUrl: widget.productImageUrl,
                            productPrice: widget.productPrice,
                            selectedExtras: selectedExtras,
                            selectedExtrasTitles: selectedExtrasTitles,
                            selectedExtrasPrices: selectedExtrasPrices,
                          ),
                        );
                        if (cartProvider.cartItemsList.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CartScreen(),
                            ),
                          );
                        }
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/payment_images/pay_here.png',
                            width: 100,
                            height: 100,
                          ),
                          const Text(
                            'Pay Here',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        final cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        cartProvider.addAndReturnToPreviousPage(
                          context,
                          CartItem(
                            cartItemId: Random().nextInt(1000000),
                            productId: widget.productId,
                            productTitle: widget.productTitle,
                            productImageUrl: widget.productImageUrl,
                            productPrice: widget.productPrice,
                            selectedExtras: selectedExtras,
                            selectedExtrasTitles: selectedExtrasTitles,
                            selectedExtrasPrices: selectedExtrasPrices,
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/payment_images/buy_continue.png',
                            width: 100,
                            height: 100,
                          ),
                          const Text(
                            'Continue Shopping',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
