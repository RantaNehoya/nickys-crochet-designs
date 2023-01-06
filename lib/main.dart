import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nickys_designs/firebase_options.dart';
import 'package:nickys_designs/models/product_model.dart';
import 'package:nickys_designs/presentation/resources/font_manager.dart';
import 'package:nickys_designs/presentation/resources/route_manager.dart';
import 'package:nickys_designs/presentation/resources/string_manager.dart';
import 'package:nickys_designs/utilities/palette.dart';
import 'package:nickys_designs/providers/cart_provider.dart';
import 'package:nickys_designs/providers/product_provider.dart';
import 'package:nickys_designs/presentation/screens/checkout_screen.dart';
import 'package:nickys_designs/presentation/screens/products_screen.dart';
import 'package:nickys_designs/presentation/screens/start_screen.dart';
import 'package:nickys_designs/presentation/screens/thankyou_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: StringManager.title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: ColorPalette.colorPalette,
          fontFamily: FontFamilies.fontFamily,
        ),
        initialRoute: Routes.start,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
