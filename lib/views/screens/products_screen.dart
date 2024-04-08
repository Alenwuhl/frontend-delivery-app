// products_screen.dart
import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/product_service.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          Column(
            children: [
              CategoryBanner(
                imageUrl: widget.categoryImageUrl,
                title: widget.categoryTitle,
              ),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: _productService.getProductsByCategory(widget.categoryId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Cantidad de columnas
                          crossAxisSpacing: 10, // Espacio horizontal entre tarjetas
                          mainAxisSpacing: 10, // Espacio vertical entre tarjetas
                          childAspectRatio: 0.8, // Ajusta la proporción según tu diseño
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var product = snapshot.data![index];
                          return ProductCard(
                            imageUrl: product['imageUrl'],
                            title: product['title'],
                            price: product['price'],
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No products found for this category'));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
