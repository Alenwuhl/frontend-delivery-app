import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/extras_service.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/cards/extra_card.dart';
import 'package:frontend_delivery_app/views/widgets/cards/product_banner.dart';

class ExtrasScreen extends StatefulWidget {
  final String productId;
  final String productTitle;
  final String productImageUrl;

  const ExtrasScreen({
    Key? key,
    required this.productId,
    required this.productTitle,
    required this.productImageUrl,
  }) : super(key: key);

  @override
  _ExtrasScreenState createState() => _ExtrasScreenState();
}

class _ExtrasScreenState extends State<ExtrasScreen> {
  late final ExtrasService _extrasService;

  @override
  void initState() {
    super.initState();
    _extrasService = ExtrasService();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: screenHeight * 0.1, 
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: ProductBanner(
                    imageUrl: widget.productImageUrl,
                    title: widget.productTitle,
                    height: screenHeight * 0.25, // Adjust the height as needed
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
                            childAspectRatio: 0.9,
                          ),
                          itemCount: extras.length,
                          itemBuilder: (context, index) {
                            var extra = extras[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExtraCard(
                                imageUrl: extra['imageUrl'],
                                title: extra['title'],
                                price: extra['price'].toString(), onIconTap: () {  },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No extras found'));
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/payment_images/pay_here.png', // Ruta de la imagen en tus assets
                        width: 100, // Ancho de la imagen
                        height: 100, // Alto de la imagen
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
