import 'package:flutter/material.dart';

class CategoryBanner extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double? height; 

  const CategoryBanner({
    super.key,
    required this.imageUrl,
    required this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = height ?? screenWidth * 0.5;

    return Container(
      width: double.infinity,
      height: bannerHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30), 
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10, 
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold, 
                fontSize: 24, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
