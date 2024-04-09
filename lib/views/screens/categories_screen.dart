import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/category_service.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/cards/category_card.dart';
import 'package:frontend_delivery_app/views/screens/products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryService categoryService;

  CategoriesScreen({Key? key})
      : categoryService = CategoryService(),
        super(key: key);

  void handleCategoryTap(
      BuildContext context, String id, String title, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsScreen(
            categoryId: id, categoryTitle: title, categoryImageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double topPadding = screenHeight * 0.05;
    double titleFontSize = screenHeight * 0.04;
    double leftPadding = screenWidth * 0.1;
    double gridSpacing = screenHeight * 0.015;
    double cardWidth = screenWidth * 0.5;
    double cardAspectRatio = 1 / 1;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          Positioned(
            right: -screenWidth * 0.3,
            bottom: screenHeight * 0.1,
            child: Image.asset(
              'assets/images/background_images/donut.png',
              width: screenWidth * 0.5,
              height: screenHeight * 0.5,
            ),
          ),
          Positioned(
            right: screenWidth * 0.35,
            bottom: screenHeight * 0.05,
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
          Padding(
            padding: EdgeInsets.only(
              left: leftPadding,
              right: screenWidth * 0.04,
              top: topPadding + MediaQuery.of(context).padding.top,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: categoryService.getCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: cardWidth,
                            childAspectRatio: cardAspectRatio,
                            crossAxisSpacing: gridSpacing,
                            mainAxisSpacing: gridSpacing,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var category = snapshot.data![index];
                            return CategoryCard(
                              id: category['id'],
                              title: category['title'],
                              imageUrl: category['imageUrl'],
                              onTap: (context, id) => handleCategoryTap(
                                context,
                                category['id'],
                                category['title'],
                                category['imageUrl'],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No categories found'));
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
