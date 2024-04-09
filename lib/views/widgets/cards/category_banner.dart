import 'package:flutter/material.dart';

class CategoryBanner extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double? height; // Optional: to pass a specific height

  const CategoryBanner({
    super.key,
    required this.imageUrl,
    required this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the width of the screen and adjust the banner size
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = height ?? screenWidth * 0.5; // Use half the width as default height if not provided

    return Container(
      width: double.infinity,
      height: bannerHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30), // Rounded corners for the banner
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10, // Position the title from the bottom of the banner
            left: 10, // Position the title from the left of the banner
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black, // Text color is black
                fontWeight: FontWeight.bold, // Bold font weight
                fontSize: 24, // Adjust the font size as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
