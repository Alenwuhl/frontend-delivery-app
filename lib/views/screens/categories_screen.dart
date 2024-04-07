import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/services/category_service.dart';

class CategoriesList extends StatelessWidget {
  final CategoryService categoryService = CategoryService();

  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    print('##############################################################');
    print('##############################################################');
    print('we are here');
    print('##############################################################');
    print('##############################################################');
    return FutureBuilder<List>(
      future: categoryService.getCategories(),
      builder: (context, snapshot) {
        print('##############################################################');
    print('##############################################################');
    print(snapshot);
    print('##############################################################');
    print('##############################################################');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No categories found'));
        } else {
          List categories = snapshot.data!;
          return SizedBox(
            height: 700.0,
            width: 300,
            child: Text(categories.toString()),
            /* child:ListView.builder(
            
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Scaffold(
                body: SizedBox(
                  height: 700,
                  width: 100,
                  child:Text(categories.toString()),
                )
                
                // Add more UI elements here based on your data model
              );
            },
          ) */);
        }
      },
    );
  }
}