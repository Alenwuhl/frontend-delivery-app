import 'package:flutter/material.dart';

class CategoryBanner extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CategoryBanner({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200, // Ajusta según tu diseño
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30), // Bordes redondeados
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white),
      ),
    );
  }
}