import 'package:flutter/material.dart';

class SelectedExtrasWidget extends StatelessWidget {
  final List<String> selectedExtrasImages;
  final List<String> selectedExtrasTitles;
  final double screenHeight;

  const SelectedExtrasWidget({
    super.key,
    required this.selectedExtrasImages,
    required this.selectedExtrasTitles,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.15, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedExtrasImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), 
                  child: Image.network(
                    selectedExtrasImages[index],
                    width: 80, 
                    height: screenHeight * 0.3,
                    fit: BoxFit.cover, 
                  ),
                ),
                const SizedBox(height: 5), 
                Text(
                  selectedExtrasTitles[index],
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
