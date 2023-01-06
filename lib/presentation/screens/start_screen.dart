import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nickys_designs/utilities/palette.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';
import 'package:nickys_designs/presentation/resources/route_manager.dart';
import 'package:nickys_designs/presentation/resources/asset_manager.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: ValueManager.v_1),
      () => Navigator.pushReplacementNamed(
        context,
        Routes.products,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.colorPalette.shade600,
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      AssetManager.logo,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: SizeManager.s_3,
                    sigmaY: SizeManager.s_3,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(
                      SizeManager.s0_3,
                    ),
                  ),
                ),
              ),
              SpinKitWave(
                color: ColorPalette.colorPalette.shade200,
                size: size.width * SizeManager.s_15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
