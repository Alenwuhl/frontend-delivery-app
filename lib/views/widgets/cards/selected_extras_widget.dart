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
      height: screenHeight * 0.15, // Ajuste de altura basado en el porcentaje del alto de la pantalla
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedExtrasImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Bordes circulares
                  child: Image.network(
                    selectedExtrasImages[index],
                    width: 80, // Tamaño fijo para todas las imágenes
                    height: screenHeight * 0.3,
                    fit: BoxFit.cover, // Ajustar la imagen al tamaño del contenedor
                  ),
                ),
                const SizedBox(height: 5), // Espacio entre la imagen y el texto
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
