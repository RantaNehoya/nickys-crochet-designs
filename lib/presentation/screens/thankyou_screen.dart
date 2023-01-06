import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:nickys_designs/utilities/palette.dart';
import 'package:nickys_designs/presentation/resources/route_manager.dart';
import 'package:nickys_designs/presentation/resources/string_manager.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';
import 'package:nickys_designs/presentation/resources/font_manager.dart';
import 'package:nickys_designs/presentation/resources/asset_manager.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
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
                Positioned(
                  top: size.height * SizeManager.s0_35,
                  child: Icon(
                    Icons.check_outlined,
                    color: ColorPalette.colorPalette.shade600,
                    size: size.width * SizeManager.s0_3,
                  ),
                ),
                Positioned(
                  top: size.height * SizeManager.s0_48,
                  child: Text(
                    StringManager.thankyou,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          mediaQueryData.textScaleFactor * FontSizeManager.f_20,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * SizeManager.s0_1,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      PaddingManager.p_15,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.products, (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPalette.colorPalette.shade600,
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * SizeManager.s0_02,
                          horizontal: size.width * SizeManager.s0_1,
                        ),
                      ),
                      child: const Text(
                        StringManager.backToHome,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
