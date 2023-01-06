import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nickys_designs/utilities/palette.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';
import 'package:nickys_designs/presentation/resources/font_manager.dart';

class DesignAppBar extends StatelessWidget with PreferredSizeWidget {
  const DesignAppBar({
    Key key,
    @required this.label,
    this.actions,
    @required this.centerTitle,
  }) : super(key: key);

  final String label;
  final bool centerTitle;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return AppBar(
      toolbarHeight: size.height * SizeManager.s0_08,
      elevation: ElevationManager.e_0,
      centerTitle: centerTitle,
      title: Padding(
        padding: const EdgeInsets.only(
          top: PaddingManager.p_8,
        ),
        child: Text(
          label,
          style: GoogleFonts.yesevaOne(
            fontSize: mediaQueryData.textScaleFactor * FontSizeManager.f_25,
          ),
        ),
      ),
      actions: actions,
      backgroundColor: ColorPalette.colorPalette.shade200,
    );
  }
}
