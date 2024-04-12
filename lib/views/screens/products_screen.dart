import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/product_service.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/screens/extras_screen.dart';
import 'package:frontend_delivery_app/views/widgets/buttons/go_back_button.dart';
import 'package:frontend_delivery_app/views/widgets/cards/category_banner.dart';
import 'package:frontend_delivery_app/views/widgets/cards/product_card.dart';

class ProductsScreen extends StatefulWidget {
  final String categoryId;
  final String categoryImageUrl;
  final String categoryTitle;

  const ProductsScreen({
    Key? key,
    required this.categoryId,
    required this.categoryImageUrl,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductService _productService;

  @override
  void initState() {
    super.initState();
    _productService = ProductService();
  }

  void handleProductTap(
      String productId, String imageUrl, String title, double price) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExtrasScreen(
          productId: productId,
          productTitle: title,
          productImageUrl: imageUrl,
          productPrice: price,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the screen width and height for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          const Positioned(
            top: 20, 
            left: 20,
            child: BackButtonWidget(),
          ),
          Positioned(
            left: screenWidth * 0.5,
            bottom: screenHeight * 0.63,
            child: Image.asset(
              'assets/images/background_images/donut.png',
              width: screenWidth * 0.5,
              height: screenHeight * 0.5,
            ),
          ),
          Positioned(
            right: screenWidth * 0.35,
            top: screenHeight * 0.05,
            child: Image.asset(
              'assets/images/background_images/x_donut.png',
              width: screenWidth * 1.4,
              height: screenHeight * 1.6,
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.01,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/cupon_image.png',
              width: screenWidth * 0.1,
              height: screenHeight * 0.1,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Category banner with image and title
                Container(
                  margin: EdgeInsets.only(
                    top: screenHeight * 0.2,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: CategoryBanner(
                    imageUrl: widget.categoryImageUrl,
                    title: widget.categoryTitle,
                    height: screenHeight * 0.25, // Adjust the height as needed
                  ),
                ),

                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: _productService
                        .getProductsByCategory(widget.categoryId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: screenWidth * 0.03,
                            mainAxisSpacing: screenHeight * 0.02,
                            childAspectRatio:
                                0.7, // Adjust to fit the product cards properly
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var product = snapshot.data![index];
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ProductCard(
                                  imageUrl: product['imageUrl'],
                                  title: product['title'],
                                  price: product['price'],
                                  onTap: () => handleProductTap(
                                    product[
                                        'id'], // Assuming 'id' is the key for productId in your data model
                                    product['imageUrl'],
                                    product['title'],
                                    product['price'],
                                  ),
                                ));
                          },
                        );
                      } else {
                        return const Center(
                            child: Text('No products found for this category'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
