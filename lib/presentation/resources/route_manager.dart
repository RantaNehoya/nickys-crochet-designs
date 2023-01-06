import 'package:flutter/material.dart';
import 'package:nickys_designs/presentation/screens/checkout_screen.dart';
import 'package:nickys_designs/presentation/screens/products_screen.dart';
import 'package:nickys_designs/presentation/screens/start_screen.dart';
import 'package:nickys_designs/presentation/screens/thankyou_screen.dart';

class Routes {
  static const String start = '/';
  static const String home = '/home';
  static const String checkout = '/checkout';
  static const String products = '/products';
  static const String thankyou = '/thankyou';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.start:
        return MaterialPageRoute(
          builder: (_) => const StartScreen(),
        );

      case Routes.checkout:
        return MaterialPageRoute(
          builder: (_) => const CheckoutScreen(),
        );

      case Routes.products:
        return MaterialPageRoute(
          builder: (_) => ProductsScreen(),
        );

      case Routes.thankyou:
        return MaterialPageRoute(
          builder: (_) => const ThankYouScreen(),
        );

      default:
        return RouteGenerator.undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
