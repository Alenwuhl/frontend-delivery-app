import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/views/screens/login_screen.dart';
import 'package:frontend_delivery_app/views/screens/register_screen.dart';
import 'package:frontend_delivery_app/views/screens/categories_screen.dart';
import 'package:frontend_delivery_app/views/screens/home_screen.dart';
import 'package:frontend_delivery_app/views/screens/timer_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case '/login':
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case '/register':
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    case '/categories':
      return MaterialPageRoute(builder: (_) => CategoriesList());
    case '/timer':
      return MaterialPageRoute(builder: (_) => TimerScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
