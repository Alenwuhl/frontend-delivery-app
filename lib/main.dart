import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/views/screens/register_screen.dart';
import 'services/category.service.dart';
import 'config/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: const RegisterScreen(),
      ),
    );
  }
}

class CategoriesList extends StatelessWidget {
  final CategoryService categoryService = CategoryService();

  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: categoryService.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No categories found'));
        } else {
          List categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]['title']),
                // Add more UI elements here based on your data model
              );
            },
          );
        }
      },
    );
  }
}
