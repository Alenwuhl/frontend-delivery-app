import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_delivery_app/services/Cart/cart_provider.dart';
import 'package:provider/provider.dart';
import './routes.dart';
import './config/firebase/firebase_options.dart';
//import 'package:flutter/services.dart' show rootBundle;
//import 'firebase_options.dart';

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cargar el contenido del archivo .env
  String dotenvContent = await rootBundle.loadString('assets/.env');
  await dotenv.loadFromString(dotenvContent);

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MaterialApp(
        title: 'Futuristic delivery App',
        initialRoute: '/',
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
