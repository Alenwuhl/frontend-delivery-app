import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './routes.dart';
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
    return const MaterialApp(
      title: 'Futuristic delivery App',
      initialRoute: '/payment', 
      onGenerateRoute: generateRoute,
    );
  }
}


