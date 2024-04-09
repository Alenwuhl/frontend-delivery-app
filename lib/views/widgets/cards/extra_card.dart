import 'package:flutter/material.dart';

class ExtraCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final void Function() onIconTap; // Añadir un callback para manejar el onTap del icono

  const ExtraCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onIconTap, // Añadir un parámetro para el callback
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Aquí se puede añadir funcionalidad adicional al onTap de la tarjeta si es necesario
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: screenWidth * 0.4, // 40% del ancho de la pantalla
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido
                  children: [
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 10), // Espaciado entre el precio y el icono
                    GestureDetector(
                      onTap: onIconTap, // Usa el callback aquí
                      child: const Icon(
                        Icons.add_box_outlined, // Icono de +
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}