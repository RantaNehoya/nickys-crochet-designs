import 'package:flutter/material.dart';
import 'package:nickys_designs/utilities/palette.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    Key key,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: ElevationManager.e_0,
        backgroundColor: ColorPalette.colorPalette.shade200,
        padding: EdgeInsets.symmetric(
          vertical: size.height * SizeManager.s0_02,
          horizontal: size.width * SizeManager.s0_2,
        ),
      ),
      child: Text(
        label,
      ),
    );
  }
}
