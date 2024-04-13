import 'package:flutter/material.dart';

class ProductBanner extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double height;

  const ProductBanner({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = height ?? screenWidth * 0.5;

    return Container(
      height: bannerHeight,
      width: double.infinity,
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
            left: 10,
            bottom: 10,
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
