import 'package:flutter/material.dart';

// Form button style
final gradientButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(30.0),
  gradient: const LinearGradient(
    colors: [
      Color.fromRGBO(239, 255, 255, 0.5),
      Color.fromRGBO(255, 252, 255, 0.5), 
    ],
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      spreadRadius: 2,
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ],
);

// Input style
final inputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.grey[600]),
  hintStyle: TextStyle(color: Colors.grey[700]),
  contentPadding: const EdgeInsets.all(20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
    borderSide: BorderSide.none,
  ),
  filled: true,
  fillColor: Colors.white.withOpacity(0.5),
);

//Container style
BoxDecoration containerDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(30.0), 
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(239, 255, 255, 0.5), 
        Color.fromRGBO(255, 252, 255, 0.5), 
      ],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1), 
        spreadRadius: 1,
        blurRadius: 10,
        offset: const Offset(0, 3), 
      ),
    ],
  );
}
