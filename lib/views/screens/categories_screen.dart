import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/category_service.dart';
import 'package:frontend_delivery_app/views/widgets/background.dart';
import 'package:frontend_delivery_app/views/widgets/cards/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryService categoryService = CategoryService();

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Stack(
        children: [
          const BackgroundStyle(useRadialGradient: false),
          FutureBuilder<List>(
            future: categoryService.getCategories(),
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var category = snapshot.data![index];
                    return CategoryCard(
                      title: category['title'],
                      imageUrl: category['imageUrl'],
                      onTap: () {
                        print('Tapped on ${category['title']}');
                      },
                    );
                  },
                );
              } else {
                return const Center(child: Text('No categories found'));
              }
            },
          ),
        ],
      ),
    );
  }
}
